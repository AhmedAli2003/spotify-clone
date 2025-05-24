import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  Injectable,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { LoginDto } from './dtos/login.dto';
import { SignUpDto } from './dtos/signup.dto';
import * as bcrypt from 'bcrypt';
import * as ms from 'ms';

const JWT_ACCESS_SECRET = 'JWT_ACCESS_SECRET';
const JWT_REFRESH_SECRET = 'JWT_REFRESH_SECRET';

const JWT_ACCESS_EXPIRES_IN = 'JWT_ACCESS_EXPIRES_IN';
const JWT_REFRESH_EXPIRES_IN = 'JWT_REFRESH_EXPIRES_IN';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
    private readonly config: ConfigService,
  ) { }

  /* ----------  SIGN-UP & LOGIN  ---------- */

  async signup(dto: SignUpDto) {
    if (await this.prisma.user.findUnique({ where: { email: dto.email } })) {
      throw new ConflictException('Email already in use');
    }

    const user = await this.prisma.user.create({
      data: {
        name: dto.name,
        email: dto.email,
        password: await bcrypt.hash(dto.password, 10),
      },
    });

    return this.issueTokensForDevice(user, dto.deviceId, dto.deviceInfo ?? null);
  }

  async login(dto: LoginDto) {
    const user = await this.prisma.user.findUnique({ where: { email: dto.email } });
    if (!user || !(await bcrypt.compare(dto.password, user.password))) {
      throw new BadRequestException('Invalid credentials');
    }

    return this.issueTokensForDevice(user, dto.deviceId, dto.deviceInfo ?? null);
  }

  /* ----------  REFRESH  ---------- */

  async refreshTokens(userId: number, refreshToken: string, deviceId: string) {
    const row = await this.prisma.refreshToken.findUnique({
      where: { user_device_unique: { userId, deviceId } },
      include: { user: true },
    });

    if (
      !row ||
      !(await bcrypt.compare(refreshToken, row.token)) ||
      row.expiresAt < new Date()
    ) {
      throw new ForbiddenException('Access denied');
    }

    // rotate
    const { accessToken, refreshToken: newRt } = await this.generateTokens(
      userId,
      row.user.email,
    );
    await this.storeRefreshToken(userId, deviceId, row.deviceInfo, newRt);

    const accessTokenExpiresIn = this.config.get(JWT_ACCESS_EXPIRES_IN);
    const refreshTokenExpiresIn = this.config.get(JWT_REFRESH_EXPIRES_IN);

    return { accessToken, refreshToken: newRt, accessTokenExpiresIn, refreshTokenExpiresIn };
  }
  
  /* ----------  LOGOUT  ---------- */

  async logout(userId: number, deviceId: string) {
    await this.prisma.refreshToken.deleteMany({
      where: { userId, deviceId },
    });
  }

  /* ----------  SHARED HELPERS  ---------- */

  private async issueTokensForDevice(
    user: { id: number; email: string; name: string },
    deviceId: string,
    deviceInfo: string | null,
  ) {
    const { accessToken, refreshToken } = await this.generateTokens(
      user.id,
      user.email,
    );

    await this.storeRefreshToken(user.id, deviceId, deviceInfo, refreshToken);

    return {
      accessToken,
      refreshToken,
      id: user.id,
      name: user.name,
      email: user.email,
      accessTokenExpiresIn: this.config.get(JWT_ACCESS_EXPIRES_IN),
      refreshTokenExpiresIn: this.config.get(JWT_REFRESH_EXPIRES_IN),
    };
  }

  private async generateTokens(userId: number, email: string) {
    const accessToken = await this.jwt.signAsync(
      { sub: userId, email },
      {
        secret: this.config.get(JWT_ACCESS_SECRET),
        expiresIn: this.config.get(JWT_ACCESS_EXPIRES_IN, '15m'),
      },
    );

    const refreshToken = await this.jwt.signAsync(
      { sub: userId, email },
      {
        secret: this.config.get(JWT_REFRESH_SECRET),
        expiresIn: this.config.get(JWT_REFRESH_EXPIRES_IN, '7d'),
      },
    );

    return { accessToken, refreshToken };
  }

  /** keeps max 3 devices, one row per (userId,deviceId) */
  private async storeRefreshToken(
    userId: number,
    deviceId: string,
    deviceInfo: string | null,
    rawToken: string,
  ) {
    // remove any old row for this device
    await this.prisma.refreshToken.deleteMany({ where: { userId, deviceId } });

    // enforce 3-device cap
    const devices = await this.prisma.refreshToken.findMany({
      where: { userId },
      orderBy: { createdAt: 'asc' },
    });
    if (devices.length >= 3) {
      await this.prisma.refreshToken.delete({ where: { id: devices[0].id } });
    }

    const ttl = ms(this.config.get(JWT_REFRESH_EXPIRES_IN, '7d'));
    const hash = await bcrypt.hash(rawToken, 10);
    const until = new Date(Date.now() + ttl);

    await this.prisma.refreshToken.create({
      data: {
        token: hash,
        userId,
        deviceId,
        deviceInfo,
        expiresAt: until,
      },
    });
  }
}
