import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:spotify_clone_app/core/theme/app_colors.dart';
import 'package:spotify_clone_app/features/home/controllers/songs_paging_controller_provider.dart';
import 'package:spotify_clone_app/features/songs/controllers/current_song_provider.dart';
import 'package:spotify_clone_app/features/songs/models/song_model.dart';

class AllSongsPaginationView extends ConsumerWidget {
  const AllSongsPaginationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagingController = ref.watch(songsPagingControllerProvider);

    return PagingListener(
      controller: pagingController,
      builder: (context, state, fetchNextPage) => PagedSliverGrid<int, Song>(
        state: state,
        fetchNextPage: fetchNextPage,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.85,
        ),
        builderDelegate: PagedChildBuilderDelegate<Song>(
          itemBuilder: (_, song, __) => GestureDetector(
            onTap: () {
              ref.read(currentSongNotifierProvider.notifier).setCurrentSong(song);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          song.thumbnailUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 180,
                    child: Text(
                      song.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: Text(
                      song.artist,
                      style: const TextStyle(
                        color: AppColors.subtitleText,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
