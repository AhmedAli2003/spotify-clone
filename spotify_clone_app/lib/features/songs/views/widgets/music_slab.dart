import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/router/app_routes.dart';
import 'package:spotify_clone_app/core/theme/app_colors.dart';
import 'package:spotify_clone_app/features/songs/controllers/current_song_provider.dart';
import 'package:spotify_clone_app/features/songs/views/widgets/current_song_play_pause_button.dart';
import 'package:spotify_clone_app/features/songs/views/widgets/favorite_song_button.dart';
import 'package:spotify_clone_app/features/songs/views/widgets/music_slab_progress_bar.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(currentSongNotifierProvider);

    if (song == null) return const SizedBox.shrink();

    final width = MediaQuery.sizeOf(context).width;
    final containerWidth = width - 16;
    final sliderWidth = width - 32;

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).goNamed(AppRoutes.musicPlayer);
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: 64,
            width: containerWidth,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: song.color,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: 'music-image',
                      child: Container(
                        width: 48,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(song.thumbnailUrl),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          song.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          song.artist,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.subtitleText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    FavoriteSongButton(songId: song.id),
                    const CurrentSongPlayPauseButton(),
                  ],
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 8,
            child: MusicSlabProgressBar(),
          ),
          Positioned(
            bottom: 0,
            left: 8,
            child: Container(
              height: 2,
              width: sliderWidth,
              decoration: const BoxDecoration(
                color: AppColors.inactiveSeekColor,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
