import { IsNotEmpty, IsHexColor, IsString } from 'class-validator';

export class CreateSongDto {
    @IsString()
    @IsNotEmpty()
    name: string;

    @IsString()
    @IsNotEmpty()
    artist: string;

    @IsHexColor()
    color: string;
}
