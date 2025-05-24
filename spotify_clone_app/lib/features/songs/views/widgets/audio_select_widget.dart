import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/widgets/custom_field.dart';
import 'package:spotify_clone_app/features/songs/controllers/song_picker_controller.dart';
import 'package:spotify_clone_app/features/songs/views/widgets/audio_wave.dart';

class AudioSelectWidget extends ConsumerWidget {
  const AudioSelectWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickedAudio = ref.watch(
      songPickerControllerProvider.select(
        (value) => value.valueOrNull?.audioFile,
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomField(
          hintText: 'Pick a song',
          readOnly: true,
          onTap: () {
            ref.read(songPickerControllerProvider.notifier).pickAudio();
          },
        ),
        if (pickedAudio != null) ...[
          const SizedBox(height: 20),
          AudioWave(path: pickedAudio.path),
        ]
      ],
    );
  }
}
