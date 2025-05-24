import { IsEmail, IsNotEmpty, IsOptional, IsString, Matches, MinLength } from 'class-validator';

export class SignUpDto {
    @IsNotEmpty()
    @Matches(
        /^(?!\d)[a-zA-Z0-9_]{2,}$/,
        { message: 'Name must be at least 2 characters, use only letters, numbers, or underscores, and cannot start with a number or contain spaces.' }
    )
    name: string;

    @IsEmail()
    email: string;

    @MinLength(6, { message: 'Password must be at least 6 characters long.' })
    password: string;

    @IsString()
    @IsNotEmpty()
    deviceId: string;

    @IsString()
    @IsOptional()
    deviceInfo?: string;
}
