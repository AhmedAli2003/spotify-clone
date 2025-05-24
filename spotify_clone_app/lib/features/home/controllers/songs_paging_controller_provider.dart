import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/features/songs/controllers/list_songs_controller.dart';
import 'package:spotify_clone_app/features/songs/models/song_model.dart';

part 'songs_paging_controller_provider.g.dart';

@riverpod
Raw<PagingController<int, Song>> songsPagingController(Ref ref) {
  final fetcher = ref.watch(listSongsControllerProvider.notifier);

  final controller = PagingController<int, Song>(
    getNextPageKey: (state) {
      final next = (state.keys?.last ?? 0) + 1;
      return next > fetcher.totalPages ? null : next;
    },
    fetchPage: (pageKey) => fetcher.fetchPage(pageKey),
  );

  ref.onDispose(() {
    controller.dispose();
  });

  return controller;
}
