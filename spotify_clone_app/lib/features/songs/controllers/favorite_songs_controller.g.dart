// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_songs_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteSongsControllerHash() =>
    r'851c84aa1f571107ebd76238a0baec1e0b4236a7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$FavoriteSongsController
    extends BuildlessAutoDisposeAsyncNotifier<FavoriteState> {
  late final int songId;

  FutureOr<FavoriteState> build(
    int songId,
  );
}

/// See also [FavoriteSongsController].
@ProviderFor(FavoriteSongsController)
const favoriteSongsControllerProvider = FavoriteSongsControllerFamily();

/// See also [FavoriteSongsController].
class FavoriteSongsControllerFamily extends Family<AsyncValue<FavoriteState>> {
  /// See also [FavoriteSongsController].
  const FavoriteSongsControllerFamily();

  /// See also [FavoriteSongsController].
  FavoriteSongsControllerProvider call(
    int songId,
  ) {
    return FavoriteSongsControllerProvider(
      songId,
    );
  }

  @override
  FavoriteSongsControllerProvider getProviderOverride(
    covariant FavoriteSongsControllerProvider provider,
  ) {
    return call(
      provider.songId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'favoriteSongsControllerProvider';
}

/// See also [FavoriteSongsController].
class FavoriteSongsControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<FavoriteSongsController,
        FavoriteState> {
  /// See also [FavoriteSongsController].
  FavoriteSongsControllerProvider(
    int songId,
  ) : this._internal(
          () => FavoriteSongsController()..songId = songId,
          from: favoriteSongsControllerProvider,
          name: r'favoriteSongsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$favoriteSongsControllerHash,
          dependencies: FavoriteSongsControllerFamily._dependencies,
          allTransitiveDependencies:
              FavoriteSongsControllerFamily._allTransitiveDependencies,
          songId: songId,
        );

  FavoriteSongsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.songId,
  }) : super.internal();

  final int songId;

  @override
  FutureOr<FavoriteState> runNotifierBuild(
    covariant FavoriteSongsController notifier,
  ) {
    return notifier.build(
      songId,
    );
  }

  @override
  Override overrideWith(FavoriteSongsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: FavoriteSongsControllerProvider._internal(
        () => create()..songId = songId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        songId: songId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FavoriteSongsController,
      FavoriteState> createElement() {
    return _FavoriteSongsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FavoriteSongsControllerProvider && other.songId == songId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, songId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FavoriteSongsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<FavoriteState> {
  /// The parameter `songId` of this provider.
  int get songId;
}

class _FavoriteSongsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FavoriteSongsController,
        FavoriteState> with FavoriteSongsControllerRef {
  _FavoriteSongsControllerProviderElement(super.provider);

  @override
  int get songId => (origin as FavoriteSongsControllerProvider).songId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
