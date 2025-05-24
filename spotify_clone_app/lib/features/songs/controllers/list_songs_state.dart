import 'package:spotify_clone_app/features/songs/models/song_model.dart';

class ListSongsState {
  final List<Song> songs;
  final int currentPage;
  final bool hasMore;

  ListSongsState({
    required this.songs,
    required this.currentPage,
    required this.hasMore,
  });

  ListSongsState copyWith({
    List<Song>? songs,
    int? currentPage,
    bool? hasMore,
  }) {
    return ListSongsState(
      songs: songs ?? this.songs,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
