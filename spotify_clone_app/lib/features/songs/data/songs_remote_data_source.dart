import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/features/songs/data/songs_api.dart';
import 'package:spotify_clone_app/features/songs/dtos/pagination_dto.dart';
import 'package:spotify_clone_app/features/songs/dtos/upload_song_dto.dart';
import 'package:spotify_clone_app/features/songs/models/paginated_songs_model.dart';
import 'package:spotify_clone_app/features/songs/models/song_model.dart';

part 'songs_remote_data_source.g.dart';

@riverpod
SongsRemoteDataSource songsRemoteDataSource(Ref ref) {
  final api = ref.watch(songsApiProvider);
  return SongsRemoteDataSourceImpl(api);
}

abstract class SongsRemoteDataSource {
  Future<void> uploadSong(UploadSongDto dto);
  Future<PaginatedSongsModel> getSongs(PaginationDto dto);
  Future<void> favoriteSong(int songId);
  Future<void> unfavoriteSong(int songId);
  Future<List<SongModel>> getFavoriteSongs();
  Future<bool> isFavoriteSong(int songId);
}

class SongsRemoteDataSourceImpl implements SongsRemoteDataSource {
  final SongsApi api;

  SongsRemoteDataSourceImpl(this.api);

  @override
  Future<void> uploadSong(UploadSongDto dto) async {
    await api.uploadSong(dto.toFormData());
  }
  
  @override
  Future<PaginatedSongsModel> getSongs(PaginationDto dto) {
    return api.getSongs(dto.toQuery());
  }
  
  @override
  Future<void> favoriteSong(int songId) {
    return api.favoriteSong(songId);
  }
  
  @override
  Future<List<SongModel>> getFavoriteSongs() {
    return api.getFavoriteSongs();
  }
  
  @override
  Future<void> unfavoriteSong(int songId) {
    return api.unfavoriteSong(songId);
  }
  
  @override
  Future<bool> isFavoriteSong(int songId) {
    return api.isFavoriteSong(songId).then((value) => value.isFavorited);
  }
}
