import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/theme/app_colors.dart';
import 'package:spotify_clone_app/features/songs/controllers/current_song_provider.dart';

class PlayerSeekSlider extends ConsumerWidget {
  const PlayerSeekSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentSongPositionStreamProvider).when(
          data: (position) {
            final duration = ref.read(currentSongNotifierProvider.notifier).getCurrentSongDuration();
            double sliderValue = 0.0;
            if (duration != null) {
              sliderValue = (position.inMilliseconds / duration.inMilliseconds).clamp(0, 1).toDouble();
            }

            return Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.whiteColor,
                    inactiveTrackColor: AppColors.inactiveSeekColor,
                    thumbColor: AppColors.whiteColor,
                    trackHeight: 4,
                    overlayShape: SliderComponentShape.noOverlay,
                  ),
                  child: Slider(
                    value: sliderValue,
                    min: 0,
                    max: 1,
                    onChanged: (val) {
                      sliderValue = val;
                    },
                    // onChangeEnd: songNotifier.seek,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${position.inMinutes}:${position.inSeconds < 10 ? '0${position.inSeconds}' : position.inSeconds}',
                      style: const TextStyle(
                        color: AppColors.subtitleText,
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      '${duration?.inMinutes}:${(duration?.inSeconds ?? 0) < 10 ? '0${duration?.inSeconds}' : duration?.inSeconds}',
                      style: const TextStyle(
                        color: AppColors.subtitleText,
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
          error: (e, st) {
            debugPrint(e.toString());
            debugPrint(st.toString());
            return Center(
              child: Text(e.toString()),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
