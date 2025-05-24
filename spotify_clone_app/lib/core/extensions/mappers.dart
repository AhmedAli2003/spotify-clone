import 'dart:io';

import 'package:spotify_clone_app/core/extensions/color_extensions.dart';
import 'package:spotify_clone_app/core/theme/app_colors.dart';
import 'package:spotify_clone_app/features/auth/models/user.dart';
import 'package:spotify_clone_app/features/songs/models/paginated_songs_model.dart';
import 'package:spotify_clone_app/features/songs/models/song_files.dart';
import 'package:spotify_clone_app/features/songs/models/song_model.dart';
import 'package:spotify_clone_app/features/songs/models/song_user_model.dart';
import 'package:spotify_clone_app/features/songs/models/songs_meta_model.dart';

extension UserModelToUser on UserModel {
  User toEntity() {
    return User(
      id: id ?? -1,
      name: 'undefined',
      email: 'undefined',
    );
  }
}

extension SongFilesModelToFiles on SongFilesModel {
  SongFiles toEntity() {
    return SongFiles(
      audioFile: audioFile ?? File(''),
      imageFile: imageFile ?? File(''),
      songName: songName ?? 'Undefined',
      artist: artist ?? 'Undefined',
      color: color ?? AppColors.transparent,
    );
  }
}

extension SongUserModelToSongUser on SongUserModel {
  SongUser toEntity() {
    return SongUser(
      id: id ?? -1,
      name: name ?? 'undefined',
    );
  }
}

extension SongModelToSong on SongModel {
  Song toEntity() {
    return Song(
      id: id ?? -1,
      name: name ?? 'undefined',
      artist: artist ?? 'undefined',
      thumbnailUrl: thumbnailUrl ?? 'undefined',
      audioUrl: audioUrl ?? 'undefined',
      color: color?.toColor() ?? AppColors.transparent,
      user: user?.toEntity() ?? const SongUser.empty(),
    );
  }
}

extension SongsMetaModelToSongsMeta on SongsMetaModel {
  SongsMeta toEntity() {
    return SongsMeta(
      limit: limit ?? 10,
      page: page ?? 1,
      total: total ?? 0,
      totalPages: totalPages ?? 0,
    );
  }
}

extension PaginatedSongsModelToPaginatedSongs on PaginatedSongsModel {
  PaginatedSongs toEntity() {
    return PaginatedSongs(
      meta: meta?.toEntity() ?? const SongsMeta.empty(),
      data: data?.map((song) => song.toEntity()).toList() ?? const <Song>[],
    );
  }
}
