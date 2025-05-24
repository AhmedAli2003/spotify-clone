import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/theme/app_colors.dart';
import 'package:spotify_clone_app/core/utils/ui_utils.dart';
import 'package:spotify_clone_app/features/songs/controllers/favorite_songs_controller.dart';

class FavoriteSongButton extends ConsumerWidget {
  const FavoriteSongButton({super.key, required this.songId});

  final int songId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteSongsControllerProvider(songId)).value?.isFavorite ?? false;

    ref.listen<AsyncValue<FavoriteState>>(
      favoriteSongsControllerProvider(songId),
      (previous, next) {
        final prevData = previous?.value;
        final nextData = next.value;

        if (prevData != null && nextData != null && nextData.wasReverted && !prevData.wasReverted) {
          showSnackBar(context, 'Failed to update favorite');
        }
      },
    );

    return IconButton(
      onPressed: () async {
        await ref.read(favoriteSongsControllerProvider(songId).notifier).toggleFavorite();
      },
      icon: Icon(
        isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
        color: AppColors.whiteColor,
      ),
    );
  }
}
