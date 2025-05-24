import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/core/router/app_routes.dart';
import 'package:spotify_clone_app/core/router/current_page_provider.dart';
import 'package:spotify_clone_app/features/songs/models/song_model.dart';
import 'package:just_audio/just_audio.dart';

part 'current_song_provider.g.dart';

@riverpod
bool audioPlayerShouldDispose(Ref ref) {
  final currentPage = ref.watch(currentPageProvider);

  const nowAllowedPages = [
    AppRoutes.login,
    AppRoutes.signup,
    AppRoutes.uploadSong,
  ];

  // Check if the current page is one of the allowed pages
  return nowAllowedPages.contains(currentPage);
}

@riverpod
AudioPlayer? currentSongAudioPlayer(Ref ref) {
  final currentSong = ref.watch(currentSongNotifierProvider);

  if (currentSong == null) return null;

  final currentSongNotifier = ref.read(currentSongNotifierProvider.notifier);

  return currentSongNotifier.getCurrentAudioPlayer();
}

@riverpod
Stream<Duration> currentSongPositionStream(Ref ref) {
  final audioPlayer = ref.watch(currentSongAudioPlayerProvider);
  return audioPlayer?.positionStream ?? const Stream.empty();
}

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier {
  AudioPlayer? _audioPlayer;

  @override
  Song? build() {
    final dispose = ref.watch(audioPlayerShouldDisposeProvider);

    final link = ref.keepAlive();

    if (dispose) {
      link.close(); // This will close the link when the page is not allowed and dispose the provider
      return null;
    }

    ref.onDispose(() {
      _audioPlayer?.dispose();
    });

    ref.onCancel(() {
      _audioPlayer?.pause();
    });

    ref.onResume(() {
      _audioPlayer?.play();
    });

    // Initialize the current song to null
    return null;
  }

  void setCurrentSong(Song song) async {
    _audioPlayer?.dispose();

    _audioPlayer = AudioPlayer();

    final audioSource = AudioSource.uri(
      Uri.parse(song.audioUrl),
    );

    _audioPlayer!.setAudioSource(audioSource);

    _audioPlayer!.play();

    ref.read(isCurrentSongPlayingProvider.notifier).setIsPlaying(true);

    // Update the current song state
    state = song;
  }

  void togglePlayPause() async {
    if (_audioPlayer == null) return;

    ref.read(isCurrentSongPlayingProvider.notifier).setIsPlaying(!_audioPlayer!.playing);

    if (_audioPlayer!.playing) {
      await _audioPlayer!.pause();
    } else {
      await _audioPlayer!.play();
    }
  }

  void toggleFavorite() {

  }

  AudioPlayer? getCurrentAudioPlayer() => _audioPlayer;
  Duration? getCurrentSongDuration() => _audioPlayer?.duration;
}

@riverpod
class IsCurrentSongPlaying extends _$IsCurrentSongPlaying {
  @override
  bool build() {
    return true;
  }

  void setIsPlaying(bool isPlaying) {
    state = isPlaying;
  }
}
