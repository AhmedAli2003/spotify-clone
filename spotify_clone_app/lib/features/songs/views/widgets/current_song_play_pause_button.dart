import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/theme/app_colors.dart';
import 'package:spotify_clone_app/features/songs/controllers/current_song_provider.dart';

class CurrentSongPlayPauseButton extends ConsumerWidget {
  const CurrentSongPlayPauseButton({
    super.key,
    this.mini = true,
  });

  final bool mini;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(isCurrentSongPlayingProvider);

    return IconButton(
      onPressed: () => ref.read(currentSongNotifierProvider.notifier).togglePlayPause(),
      icon: Icon(
        getIcon(isPlaying),
        color: AppColors.whiteColor,
        size: mini ? 20 : 80,
      ),
    );
  }

  IconData getIcon(bool isPlaying) {
    if (mini && isPlaying) {
      return CupertinoIcons.pause_fill;
    } else if (mini && !isPlaying) {
      return CupertinoIcons.play_fill;
    } else if (!mini && isPlaying) {
      return CupertinoIcons.pause_circle_fill;
    } else {
      return CupertinoIcons.play_circle_fill;
    }
  }
}
