import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/theme/app_colors.dart';
import 'package:spotify_clone_app/features/songs/controllers/current_song_provider.dart';

class MusicSlabProgressBar extends ConsumerWidget {
  const MusicSlabProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sliderWidth = MediaQuery.sizeOf(context).width - 32;

    return ref.watch(currentSongPositionStreamProvider).when(
          data: (position) {
            final duration = ref.read(currentSongNotifierProvider.notifier).getCurrentSongDuration();
            if (duration == null) return const SizedBox.shrink();
            final sliderValue = position.inMilliseconds / duration.inMilliseconds;
            return Container(
              height: 2,
              width: sliderValue * sliderWidth,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            );
          },
          error: (error, st) {
            debugPrint(error.toString());
            debugPrint(st.toString());
            return const SizedBox.shrink();
          },
          loading: () => const SizedBox.shrink(),
        );
  }
}
