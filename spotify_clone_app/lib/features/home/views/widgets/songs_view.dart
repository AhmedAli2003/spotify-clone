import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/theme/app_colors.dart';
import 'package:spotify_clone_app/features/home/views/widgets/all_songs_pagination_view.dart';
import 'package:spotify_clone_app/features/home/views/widgets/latest_songs_view.dart';
import 'package:spotify_clone_app/features/home/views/widgets/sliver_section_title.dart';
import 'package:spotify_clone_app/features/songs/controllers/current_song_provider.dart';

class SongsView extends ConsumerWidget {
  const SongsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: currentSong == null
          ? null
          : BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  currentSong.color,
                  AppColors.transparent,
                ],
                stops: const [0.0, 0.3],
              ),
            ),
      child: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 32)),
          SliverSectionTitle(title: 'Latest today'),
          LatestSongsSliver(),
          SliverSectionTitle(title: 'Popular'),
          AllSongsPaginationView(),
        ],
      ),
    );
  }
}

