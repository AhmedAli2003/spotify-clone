import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/features/songs/dtos/pagination_dto.dart';
import 'package:spotify_clone_app/features/songs/models/song_model.dart';
import 'package:spotify_clone_app/features/songs/repositories/songs_repository.dart';

part 'list_songs_controller.g.dart';

@riverpod
class ListSongsController extends _$ListSongsController {
  late final SongsRepository _repo;

  int _cachedTotalPages = 1; // <-- hold it here
  // ignore: avoid_public_notifier_properties
  int get totalPages => _cachedTotalPages;

  @override
  Future<void> build() {
    _repo = ref.watch(songsRepositoryProvider);
    return Future.value();
  }

  Future<List<Song>> fetchPage(int page) async {
    final dto = PaginationDto(page: page, limit: 6);
    final result = await _repo.getSongs(dto);
    _cachedTotalPages = result.meta.totalPages;
    return result.data;
  }
}

@riverpod
Future<List<Song>> newSongs(Ref ref) {
  final controller = ref.watch(listSongsControllerProvider.notifier);
  return controller.fetchPage(1);
}
