import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/errors/failure.dart';
import 'package:spotify_clone_app/core/theme/app_colors.dart';
import 'package:spotify_clone_app/core/utils/ui_utils.dart';
import 'package:spotify_clone_app/core/widgets/custom_field.dart';
import 'package:spotify_clone_app/features/songs/controllers/song_picker_controller.dart';
import 'package:spotify_clone_app/features/songs/views/widgets/audio_select_widget.dart';
import 'package:spotify_clone_app/features/songs/views/widgets/thumbnail_widget.dart';
import 'package:spotify_clone_app/features/songs/views/widgets/upload_song_button.dart';

class UploadSongPage extends HookConsumerWidget {
  const UploadSongPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artistController = useTextEditingController();
    final songNameController = useTextEditingController();

    final selectedColor = useState<Color>(AppColors.cardColor);

    ref.listen(
      songPickerControllerProvider,
      (_, next) => next.when(
        data: (data) {
          debugPrint('SongPicker Audio: ${data.audioFile}');
          debugPrint('SongPicker Image: ${data.imageFile}');
        },
        error: (e, st) {
          if (e is Failure) {
            showSnackBar(context, e.message);
          } else {
            debugPrint('Error: $e');
            debugPrint('StackTrace: $st');
            showSnackBar(context, e.toString());
          }
        },
        loading: () {},
      ),
    );

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Upload Song'),
        actions: const [UploadSongButton()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const ThumbnailWidget(),
              const SizedBox(height: 40),
              const AudioSelectWidget(),
              const SizedBox(height: 20),
              CustomField(
                controller: artistController,
                hintText: 'Artist',
                onChanged: (songName) {
                  ref.read(songPickerControllerProvider.notifier).updateArtistName(songName);
                },
              ),
              const SizedBox(height: 20),
              CustomField(
                controller: songNameController,
                hintText: 'Song name',
                onChanged: (songName) {
                  ref.read(songPickerControllerProvider.notifier).updateSongName(songName);
                },
              ),
              const SizedBox(height: 20),
              ColorPicker(
                color: selectedColor.value,
                pickersEnabled: {
                  ColorPickerType.wheel: true,
                },
                onColorChanged: (color) {
                  selectedColor.value = color;
                  ref.read(songPickerControllerProvider.notifier).updateColor(color);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
