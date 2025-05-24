import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/features/songs/models/song_files.dart';
import 'package:spotify_clone_app/features/songs/plugins/song_picker.dart';

part 'song_picker_controller.g.dart';

@riverpod
class SongPickerController extends _$SongPickerController {
  late final SongPicker _songPicker;
  var _songFilesModel = const SongFilesModel();

  @override
  FutureOr<SongFilesModel> build() {
    _songPicker = ref.watch(songPickerProvider);
    return const SongFilesModel();
  }

  Future<void> pickAudio() async {
    state = await AsyncValue.guard(() async {
      final file = await _songPicker.pickAudio();
      _songFilesModel = _songFilesModel.copyWith(audioFile: file);
      return _songFilesModel;
    });
  }

  Future<void> pickImage() async {
    state = await AsyncValue.guard(() async {
      final file = await _songPicker.pickImage();
      _songFilesModel = _songFilesModel.copyWith(imageFile: file);
      return _songFilesModel;
    });
  }

  void clearAudio() {
    _songFilesModel = SongFilesModel(
      imageFile: _songFilesModel.imageFile,
    );
    state = AsyncData(_songFilesModel);
  }

  void clearImage() {
    _songFilesModel = SongFilesModel(
      audioFile: _songFilesModel.audioFile,
    );
    state = AsyncData(_songFilesModel);
  }

  void clear() {
    state = const AsyncData(SongFilesModel());
  }

  void updateArtistName(String artist) {
    _songFilesModel = _songFilesModel.copyWith(artist: artist);
    state = AsyncData(_songFilesModel);
  }

  void updateSongName(String name) {
    _songFilesModel = _songFilesModel.copyWith(songName: name);
    state = AsyncData(_songFilesModel);
  }

  void updateColor(Color color) {
    _songFilesModel = _songFilesModel.copyWith(color: color);
    state = AsyncData(_songFilesModel);
  }
}
