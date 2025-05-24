import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/core/errors/error_handler.dart';
import 'package:spotify_clone_app/core/errors/failure.dart';

part 'song_picker.g.dart';

@riverpod
SongPicker songPicker(Ref _) => SongPickerImpl();

abstract class SongPicker {
  Future<File> pickAudio();
  Future<File> pickImage();
}

class SongPickerImpl implements SongPicker {
  @override
  Future<File> pickAudio() {
    return ErrorHandler.asyncWrapper(() async {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );

      if (file == null || file.files.isEmpty) {
        throw const Failure('No file selected');
      }

      return File(file.files.first.xFile.path);
    });
  }

  @override
  Future<File> pickImage() {
    return ErrorHandler.asyncWrapper(() async {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (file == null || file.files.isEmpty) {
        throw const Failure('No file selected');
      }

      return File(file.files.first.xFile.path);
    });
  }
}
