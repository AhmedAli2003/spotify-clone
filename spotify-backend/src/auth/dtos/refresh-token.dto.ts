import { IsNotEmpty, IsInt, IsString } from 'class-validator';

export class RefreshTokenDto {
  @IsInt()
  @IsNotEmpty()
  userId: number;

  @IsString()
  @IsNotEmpty()
  refreshToken: string;

  @IsString()
  @IsNotEmpty()
  deviceId: string;
}