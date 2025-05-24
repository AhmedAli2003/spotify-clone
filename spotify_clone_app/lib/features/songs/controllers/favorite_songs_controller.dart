// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:spotify_clone_app/features/songs/repositories/songs_repository.dart';

part 'favorite_songs_controller.g.dart';

@riverpod
class FavoriteSongsController extends _$FavoriteSongsController {
  late final SongsRepository _repo;
  bool _isToggling = false;

  @override
  FutureOr<FavoriteState> build(int songId) async {
    _repo = ref.watch(songsRepositoryProvider);
    final isFavorite = await _repo.isFavoriteSong(songId);
    return FavoriteState(isFavorite: isFavorite);
  }

  Future<void> toggleFavorite() async {
    if (_isToggling) return;
    _isToggling = true;

    final current = state.value!;
    final optimisticState = current.copyWith(
      isFavorite: !current.isFavorite,
      wasReverted: false,
      isLoading: true,
    );

    state = AsyncData(optimisticState);

    final success = optimisticState.isFavorite ? await _repo.favoriteSong(songId) : await _repo.unfavoriteSong(songId);

    if (!success) {
      // Revert the change and mark it as reverted
      state = AsyncData(
        current.copyWith(wasReverted: true, isLoading: false),
      );
    } else {
      // Confirm success and clear loading
      state = AsyncData(
        optimisticState.copyWith(isLoading: false),
      );
    }

    _isToggling = false;
  }
}

class FavoriteState {
  final bool isFavorite;
  // Only true if a rollback occurred due to backend failure
  final bool wasReverted;
  final bool isLoading;

  const FavoriteState({
    required this.isFavorite,
    this.wasReverted = false,
    this.isLoading = false,
  });

  FavoriteState copyWith({
    bool? isFavorite,
    bool? wasReverted,
    bool? isLoading,
  }) {
    return FavoriteState(
      isFavorite: isFavorite ?? this.isFavorite,
      wasReverted: wasReverted ?? this.wasReverted,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(covariant FavoriteState other) {
    if (identical(this, other)) return true;

    return other.isFavorite == isFavorite && other.wasReverted == wasReverted && other.isLoading == isLoading;
  }

  @override
  int get hashCode => isFavorite.hashCode ^ wasReverted.hashCode ^ isLoading.hashCode;
}
