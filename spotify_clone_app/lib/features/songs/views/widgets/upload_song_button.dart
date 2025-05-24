import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/errors/failure.dart';
import 'package:spotify_clone_app/core/extensions/mappers.dart';
import 'package:spotify_clone_app/core/router/app_routes.dart';
import 'package:spotify_clone_app/core/utils/ui_utils.dart';
import 'package:spotify_clone_app/features/songs/controllers/song_picker_controller.dart';
import 'package:spotify_clone_app/features/songs/controllers/song_upload_controller.dart';
import 'package:spotify_clone_app/features/songs/models/song_files.dart';

class UploadSongButton extends ConsumerWidget {
  const UploadSongButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(songPickerControllerProvider).asData?.value;

    final isLoading = ref.watch(
      songsUploadControllerProvider.select(
        (value) => value.isLoading,
      ),
    );

    ref.listen(songsUploadControllerProvider, (_, next) {
      next.when(
        data: (_) {
          ref.read(songPickerControllerProvider.notifier).clear();
          Navigator.of(context, rootNavigator: true).pop(); // dismiss dialog
          GoRouter.of(context).goNamed(AppRoutes.home); // go to home page
        },
        error: (error, st) {
          Navigator.of(context, rootNavigator: true).pop(); // dismiss dialog
          if (error is Failure) {
            showSnackBar(context, error.message);
          } else {
            debugPrint('Error: $error');
            debugPrint('StackTrace: $st');
            showSnackBar(context, error.toString());
          }
        },
        loading: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
    });

    final songInfoAreFilled = song != null &&
        song.audioFile != null &&
        song.imageFile != null &&
        song.artist != null &&
        song.artist!.isNotEmpty &&
        song.songName != null &&
        song.songName!.isNotEmpty &&
        song.color != null;

    return IconButton(
      onPressed: isLoading
          ? null
          : songInfoAreFilled
              ? () => uploadSong(context, ref, song)
              : () => viewSnackBar(context, song),
      icon: const Icon(Icons.check),
    );
  }

  void viewSnackBar(BuildContext context, SongFilesModel? song) {
    if (song == null) {
      showSnackBar(context, 'Please select a song');
    } else if (song.audioFile == null) {
      showSnackBar(context, 'Please select an audio file');
    } else if (song.imageFile == null) {
      showSnackBar(context, 'Please select an image file');
    } else if (song.artist == null || song.artist!.isEmpty) {
      showSnackBar(context, 'Please enter the artist name');
    } else if (song.songName == null || song.songName!.isEmpty) {
      showSnackBar(context, 'Please enter the song name');
    } else if (song.color == null) {
      showSnackBar(context, 'Please select a color');
    }
  }

  void uploadSong(
    BuildContext context,
    WidgetRef ref,
    SongFilesModel song,
  ) {
    ref.read(songsUploadControllerProvider.notifier).uploadSong(song.toEntity());
  }
}
