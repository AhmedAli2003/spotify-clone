// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_song_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audioPlayerShouldDisposeHash() =>
    r'5ade09d7cc3aab96392db16562a5e98c2e4124c2';

/// See also [audioPlayerShouldDispose].
@ProviderFor(audioPlayerShouldDispose)
final audioPlayerShouldDisposeProvider = AutoDisposeProvider<bool>.internal(
  audioPlayerShouldDispose,
  name: r'audioPlayerShouldDisposeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audioPlayerShouldDisposeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AudioPlayerShouldDisposeRef = AutoDisposeProviderRef<bool>;
String _$currentSongAudioPlayerHash() =>
    r'b235a3fb74650439766a7dc03c4395b7c27b7191';

/// See also [currentSongAudioPlayer].
@ProviderFor(currentSongAudioPlayer)
final currentSongAudioPlayerProvider =
    AutoDisposeProvider<AudioPlayer?>.internal(
  currentSongAudioPlayer,
  name: r'currentSongAudioPlayerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSongAudioPlayerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentSongAudioPlayerRef = AutoDisposeProviderRef<AudioPlayer?>;
String _$currentSongPositionStreamHash() =>
    r'ff0aa94479b6e003b7da68b74980d68b65929969';

/// See also [currentSongPositionStream].
@ProviderFor(currentSongPositionStream)
final currentSongPositionStreamProvider =
    AutoDisposeStreamProvider<Duration>.internal(
  currentSongPositionStream,
  name: r'currentSongPositionStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSongPositionStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentSongPositionStreamRef = AutoDisposeStreamProviderRef<Duration>;
String _$currentSongNotifierHash() =>
    r'7da925cd7aef1654b9ffb2c42782d5f386ca3cf7';

/// See also [CurrentSongNotifier].
@ProviderFor(CurrentSongNotifier)
final currentSongNotifierProvider =
    AutoDisposeNotifierProvider<CurrentSongNotifier, Song?>.internal(
  CurrentSongNotifier.new,
  name: r'currentSongNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSongNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentSongNotifier = AutoDisposeNotifier<Song?>;
String _$isCurrentSongPlayingHash() =>
    r'42483468c0eb4cb92519dc6439dfea4dbdb49a06';

/// See also [IsCurrentSongPlaying].
@ProviderFor(IsCurrentSongPlaying)
final isCurrentSongPlayingProvider =
    AutoDisposeNotifierProvider<IsCurrentSongPlaying, bool>.internal(
  IsCurrentSongPlaying.new,
  name: r'isCurrentSongPlayingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isCurrentSongPlayingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsCurrentSongPlaying = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
