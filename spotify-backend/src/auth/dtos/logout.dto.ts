import { IsNotEmpty, IsInt, IsString } from 'class-validator';

export class LogoutDto {
  @IsInt()
  @IsNotEmpty()
  userId: number;

  @IsString()
  @IsNotEmpty()
  deviceId: string;
}
