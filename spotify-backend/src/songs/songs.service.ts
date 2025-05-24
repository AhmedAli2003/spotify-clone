import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { CloudinaryService } from 'src/cloudinary/cloudinary.service';
import { CreateSongDto } from './dtos/create-song.dto';

@Injectable()
export class SongsService {
  constructor(
    private prisma: PrismaService,
    private cloudinary: CloudinaryService,
  ) { }

  async createSongWithCloudinary(
    userId: number | undefined,
    dto: CreateSongDto,
    files: Express.Multer.File[],
  ) {

    if (!userId) throw new Error('Missing user ID');

    const audioFile = files.find((f) => f.mimetype.startsWith('audio/'));
    const thumbnailFile = files.find((f) => f.mimetype.startsWith('image/'));

    if (!audioFile?.buffer) throw new Error('Missing audio file buffer');
    if (!thumbnailFile?.buffer) throw new Error('Missing thumbnail file buffer');

    try {
      const [audioUpload, thumbnailUpload] = await Promise.all([
        this.cloudinary.uploadFile(audioFile.buffer, 'songs/audio', 'video'),
        this.cloudinary.uploadFile(thumbnailFile.buffer, 'songs/thumbnails', 'image'),
      ]);

      return await this.prisma.song.create({
        data: {
          name: dto.name,
          artist: dto.artist,
          color: dto.color,
          audioPath: audioUpload.url,
          thumbnailPath: thumbnailUpload.url,
          user: {
            connect: {
              id: userId,
            },
          },
        },
      });
    } catch (err) {
      console.error('❌ Upload failed:', err);
      throw new Error('Failed to upload to Cloudinary');
    }
  }


  async getSongs(page: number = 1, limit: number = 10) {
    const skip = (page - 1) * limit;

    const [songs, total] = await this.prisma.$transaction([
      this.prisma.song.findMany({
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          user: {
            select: {
              id: true,
              name: true,
            },
          },
        },
      }),
      this.prisma.song.count(),
    ]);

    return {
      data: songs.map((song) => {
        return {
          id: song.id,
          name: song.name,
          artist: song.artist,
          color: song.color,
          audioUrl: song.audioPath,
          thumbnailUrl: song.thumbnailPath,
          user: {
            id: song.user.id,
            name: song.user.name,
          },
        };
      }),
      meta: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async favoriteSong(userId: number, songId: number) {
    // Avoid duplicate favorite (safe insert)
    return this.prisma.favorite.upsert({
      where: {
        userId_songId: {
          userId,
          songId
        }
      },
      update: {}, // no update needed, just skip
      create: {
        userId,
        songId
      }
    });
  }

  async unfavoriteSong(userId: number, songId: number) {
    return this.prisma.favorite.delete({
      where: {
        userId_songId: {
          userId,
          songId
        }
      }
    });
  }

  async getFavoriteSongs(userId: number) {
    const favorites = await this.prisma.favorite.findMany({
      where: { userId },
      include: {
        song: true
      }
    });

    return favorites.map(fav => fav.song);
  }

  async isSongFavorited(userId: number, songId: number): Promise<boolean> {
    const favorite = await this.prisma.favorite.findUnique({
      where: {
        userId_songId: {
          userId,
          songId,
        },
      },
      select: { id: true }, // only get what you need
    });

    return favorite !== null;
  }

}
