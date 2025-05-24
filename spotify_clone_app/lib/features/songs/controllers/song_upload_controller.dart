import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/core/errors/failure.dart';
import 'package:spotify_clone_app/core/extensions/color_extensions.dart';
import 'package:spotify_clone_app/features/songs/dtos/upload_song_dto.dart';
import 'package:spotify_clone_app/features/songs/models/song_files.dart';
import 'package:spotify_clone_app/features/songs/repositories/songs_repository.dart';

part 'song_upload_controller.g.dart';

@riverpod
class SongsUploadController extends _$SongsUploadController {
  late final SongsRepository _repo;

  @override
  FutureOr<void> build() {
    _repo = ref.watch(songsRepositoryProvider);
  }

  Future<void> uploadSong(SongFiles song) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final audioName = song.audioFile.path.split('/').lastOrNull;
      final imageName = song.imageFile.path.split('/').lastOrNull;

      if (audioName == null) {
        throw const Failure('Cannot get audio name');
      }

      if (imageName == null) {
        throw const Failure('Cannot get image name');
      }

      final [audioMultipart, imageMultipart] = await Future.wait([
        MultipartFile.fromFile(
          song.audioFile.path,
          filename: audioName,
          contentType: _getMediaType(song.audioFile.path),
        ),
        MultipartFile.fromFile(
          song.imageFile.path,
          filename: imageName,
          contentType: _getMediaType(song.imageFile.path),
        )
      ]);

      final dto = UploadSongDto(
        audioMultipart: audioMultipart,
        imageMultipart: imageMultipart,
        name: song.songName,
        artist: song.artist,
        color: song.color.toHex(),
      );

      await _repo.uploadSong(dto);
    });
  }

  MediaType _getMediaType(String path) {
    final mimeType = lookupMimeType(path);
    if (mimeType == null) {
      throw const Failure('Could not determine file type');
    }

    final parts = mimeType.split('/');
    return MediaType(parts[0], parts[1]);
  }
}
