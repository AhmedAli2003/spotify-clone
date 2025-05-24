import { Body, Controller, Post } from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignUpDto } from './dtos/signup.dto';
import { LoginDto } from './dtos/login.dto';
import { LogoutDto } from './dtos/logout.dto';
import { RefreshTokenDto } from './dtos/refresh-token.dto';

@Controller('auth')
export class AuthController {
    constructor(
        private readonly authService: AuthService,
    ) { }

    @Post('login')
    login(@Body() body: LoginDto) {
        return this.authService.login(body);
    }

    @Post('sign-up')
    signUp(@Body() body: SignUpDto) {
        return this.authService.signup(body);
    }

    @Post('refresh')
    async refresh(@Body() body: RefreshTokenDto) {
        return this.authService.refreshTokens(body.userId, body.refreshToken, body.deviceId);
    }

    @Post('logout')
    async logout(@Body() body: LogoutDto) {
        return this.authService.logout(body.userId, body.deviceId);
    }
}
