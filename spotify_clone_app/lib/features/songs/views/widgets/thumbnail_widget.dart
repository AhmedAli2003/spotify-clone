import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/theme/app_colors.dart';
import 'package:spotify_clone_app/features/songs/controllers/song_picker_controller.dart';

class ThumbnailWidget extends ConsumerWidget {
  const ThumbnailWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickedImage = ref.watch(
      songPickerControllerProvider.select(
        (value) => value.valueOrNull?.imageFile,
      ),
    );

    return GestureDetector(
      onTap: () {
        ref.read(songPickerControllerProvider.notifier).pickImage();
      },
      onLongPress: () {
        ref.read(songPickerControllerProvider.notifier).clearImage();
      },
      child: DottedBorder(
        options: const RoundedRectDottedBorderOptions(
          radius: Radius.circular(10),
          strokeCap: StrokeCap.round,
          color: AppColors.borderColor,
          dashPattern: [10, 4],
        ),
        child: pickedImage != null
            ? ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.file(
                  pickedImage,
                  width: double.maxFinite,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              )
            : const SizedBox(
                height: 150,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder_open,
                      size: 40,
                    ),
                    Text('Select the thumbnail for your song'),
                  ],
                ),
              ),
      ),
    );
  }
}
