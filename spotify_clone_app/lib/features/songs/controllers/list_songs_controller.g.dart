// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_songs_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newSongsHash() => r'dc0498b059cb7f6efd3eb8a53f52c9ed6f5a28d7';

/// See also [newSongs].
@ProviderFor(newSongs)
final newSongsProvider = AutoDisposeFutureProvider<List<Song>>.internal(
  newSongs,
  name: r'newSongsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$newSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NewSongsRef = AutoDisposeFutureProviderRef<List<Song>>;
String _$listSongsControllerHash() =>
    r'5c34cf0dc7999bade3f3f1054c9a0e85e547a312';

/// See also [ListSongsController].
@ProviderFor(ListSongsController)
final listSongsControllerProvider =
    AutoDisposeAsyncNotifierProvider<ListSongsController, void>.internal(
  ListSongsController.new,
  name: r'listSongsControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$listSongsControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ListSongsController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
