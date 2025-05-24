import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/core/errors/error_handler.dart';
import 'package:spotify_clone_app/core/extensions/mappers.dart';
import 'package:spotify_clone_app/features/songs/data/songs_remote_data_source.dart';
import 'package:spotify_clone_app/features/songs/dtos/pagination_dto.dart';
import 'package:spotify_clone_app/features/songs/dtos/upload_song_dto.dart';
import 'package:spotify_clone_app/features/songs/models/paginated_songs_model.dart';
import 'package:spotify_clone_app/features/songs/models/song_model.dart';

part 'songs_repository.g.dart';

@riverpod
SongsRepository songsRepository(Ref ref) {
  final remoteDataSource = ref.watch(songsRemoteDataSourceProvider);
  return SongsRepositoryImpl(remoteDataSource);
}

abstract class SongsRepository {
  Future<void> uploadSong(UploadSongDto dto);
  Future<PaginatedSongs> getSongs(PaginationDto dto);
  Future<bool> favoriteSong(int songId);
  Future<bool> unfavoriteSong(int songId);
  Future<bool> isFavoriteSong(int songId);
  Future<List<Song>> getFavoriteSongs();
}

class SongsRepositoryImpl implements SongsRepository {
  final SongsRemoteDataSource remoteDataSource;

  const SongsRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> uploadSong(UploadSongDto dto) async {
    return ErrorHandler.asyncWrapper(() async {
      return await remoteDataSource.uploadSong(dto);
    });
  }

  @override
  Future<PaginatedSongs> getSongs(PaginationDto dto) {
    return ErrorHandler.asyncWrapper(() async {
      final paginatedSongsModel = await remoteDataSource.getSongs(dto);
      return paginatedSongsModel.toEntity();
    });
  }

  @override
  Future<bool> favoriteSong(int songId) async {
    return ErrorHandler.booleanWrapper(() async {
      return await remoteDataSource.favoriteSong(songId);
    });
  }

  @override
  Future<bool> unfavoriteSong(int songId) {
    return ErrorHandler.booleanWrapper(() async {
      return await remoteDataSource.unfavoriteSong(songId);
    });
  }

  @override
  Future<List<Song>> getFavoriteSongs() {
    return ErrorHandler.asyncWrapper(() async {
      final favoriteSongs = await remoteDataSource.getFavoriteSongs();
      return favoriteSongs.map((e) => e.toEntity()).toList();
    });
  }
  
  @override
  Future<bool> isFavoriteSong(int songId) async {
    return ErrorHandler.falseWhenFailedWrapper(() async {
      return await remoteDataSource.isFavoriteSong(songId);
    });
  }
}
