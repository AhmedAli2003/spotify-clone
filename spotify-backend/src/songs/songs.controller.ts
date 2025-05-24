import {
    Controller,
    Post,
    UploadedFiles,
    UseInterceptors,
    Body,
    UseGuards,
    Req,
    Get,
    Query,
    ParseIntPipe,
    Param,
    Delete,
} from '@nestjs/common';
import { FilesInterceptor } from '@nestjs/platform-express';
import { CreateSongDto } from './dtos/create-song.dto';
import { SongsService } from './songs.service';
import { memoryStorage } from 'multer';
import { AuthGuard } from 'src/auth/guards/auth.guard';
import { Request } from 'express';
import { PaginationDto } from './dtos/pagination.dto';

@Controller('songs')
export class SongsController {
    constructor(private readonly songsService: SongsService) { }

    @Post('upload')
    @UseGuards(AuthGuard)
    @UseInterceptors(
        FilesInterceptor('files', 2, {
            storage: memoryStorage(),
            fileFilter: (req, file, cb) => {
                if (
                    file.mimetype.startsWith('audio/') ||
                    file.mimetype.startsWith('image/')
                ) {
                    cb(null, true);
                } else {
                    cb(new Error('Invalid file type'), false);
                }
            },
        }),
    )
    async uploadSong(
        @Req() req: Request,
        @UploadedFiles() files: Express.Multer.File[],
        @Body() body: CreateSongDto,
    ) {
        return this.songsService.createSongWithCloudinary(req.user?.sub, body, files);
    }

    @Get()
    @UseGuards(AuthGuard)
    async getSongs(
        @Query() { page, limit }: PaginationDto
    ) {
        return this.songsService.getSongs(page, limit);
    }

    @Post('favorite/:songId')
    @UseGuards(AuthGuard)
    async favoriteSong(
        @Param('songId', ParseIntPipe) songId: number,
        @Req() req: Request,
    ) {
        const userId = req.user?.sub;
        if (!userId) throw new Error('User ID not found');
        return this.songsService.favoriteSong(songId, userId);
    }

    @Delete('unfavorite/:songId')
    @UseGuards(AuthGuard)
    async unfavoriteSong(
        @Param('songId', ParseIntPipe) songId: number,
        @Req() req: Request,
    ) {
        const userId = req.user?.sub;
        if (!userId) throw new Error('User ID not found');
        return this.songsService.unfavoriteSong(songId, userId);
    }

    @Get()
    @UseGuards(AuthGuard)
    async getMyFavorites(@Req() req) {
        const userId = req.user.sub;
        return this.songsService.getFavoriteSongs(userId);
    }

    @Get('is-favorited/:songId')
    @UseGuards(AuthGuard)
    async isFavorited(
        @Param('songId', ParseIntPipe) songId: number,
        @Req() req
    ) {
        const userId = req.user.sub;
        const isFavorited = await this.songsService.isSongFavorited(userId, songId);
        return { isFavorited };
    }
}
