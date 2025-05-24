import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/core/errors/error_handler.dart';
import 'package:spotify_clone_app/core/extensions/mappers.dart';
import 'package:spotify_clone_app/core/utils/device_info.dart';
import 'package:spotify_clone_app/core/utils/in_memory_store.dart';
import 'package:spotify_clone_app/features/auth/data/auth_local_data_source.dart';
import 'package:spotify_clone_app/features/auth/data/auth_remote_data_source.dart';
import 'package:spotify_clone_app/features/auth/dtos/login_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/logout_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/refresh_token_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/register_dto.dart';
import 'package:spotify_clone_app/features/auth/models/tokens_model.dart';
import 'package:spotify_clone_app/features/auth/models/user.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  final deviceInfo = ref.watch(deviceInfoProvider);

  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    deviceInfo: deviceInfo,
  );
}

/// Abstract repository interface
abstract class AuthRepository {
  Stream<User?> get userStream;
  InMemoryStore<User?> get userStore;
  Future<User> login(LoginDto loginDto);
  Future<User> signup(RegisterDto registerDto);
  Future<void> refreshTokens(RefreshTokenDto refreshTokenDto);
  Future<void> logout(LogoutDto logoutDto);
  Future<bool> ensureTokensValid();
}

/// Concrete implementation
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final DeviceInfo deviceInfo;

  final _userStore = InMemoryStore<User?>(null);

  @override
  Stream<User?> get userStream => _userStore.stream;

  User? get currentUser => _userStore.value;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.deviceInfo,
  });

  @override
  InMemoryStore<User?> get userStore => _userStore;

  @override
  Future<User> login(LoginDto loginDto) {
    return ErrorHandler.asyncWrapper(() async {
      // Complete the login process
      final userModel = await remoteDataSource.login(loginDto);

      // Cache the user data locally on shared preferences
      await localDataSource.cacheUser(userModel);

      // Cache the tokens locally on shared preferences
      await localDataSource.cacheTokens(
        TokensModel(
          accessToken: userModel.accessToken,
          refreshToken: userModel.refreshToken,
          accessTokenExpiresIn: userModel.accessTokenExpiresIn,
          refreshTokenExpiresIn: userModel.refreshTokenExpiresIn,
        ),
      );

      // Update the in-memory store with the user data to notify app router
      _userStore.value = userModel.toEntity();

      // Convert to domain entity
      return userModel.toEntity();
    });
  }

  @override
  Future<User> signup(RegisterDto registerDto) {
    return ErrorHandler.asyncWrapper(() async {
      final userModel = await remoteDataSource.signup(registerDto);

      // NOTE: the user won't be logged in automatically after signup, they need to login
      // Cache the user data locally on shared preferences
      // await localDataSource.cacheUser(userModel);

      // NOTE: the user won't be logged in automatically after signup, they need to login
      // Update the in-memory store with the user data to notify app router
      // _userStore.value = userModel.toEntity();

      // Convert to domain entity
      return userModel.toEntity();
    });
  }

  @override
  Future<void> logout(LogoutDto logoutDto) {
    return ErrorHandler.asyncWrapper(() async {
      // Update the in-memory store with the user data to notify app router
      _userStore.value = null;

      // Logout the user from the remote server
      await remoteDataSource.logout(logoutDto);

      // Clear the cached user data from shared preferences
      await localDataSource.removeCachedUser();

      // Clear the cached tokens from shared preferences
      await localDataSource.removeTokens();
    });
  }

  @override
  Future<void> refreshTokens(RefreshTokenDto refreshTokenDto) {
    return ErrorHandler.asyncWrapper(() async {
      // Get the new tokens from the remote server
      final tokensModel = await remoteDataSource.refreshTokens(refreshTokenDto);

      // Cache the tokens locally on shared preferences
      await localDataSource.cacheTokens(tokensModel);
    });
  }

  static const _kRefreshGrace = Duration(hours: 1);

  /// Ensures access / refresh tokens are usable.
  /// Returns `true` if the user is kept signed-in, `false` otherwise.
  @override
  Future<bool> ensureTokensValid() {
    return ErrorHandler.asyncWrapper(() async {
      // ---------- Pull everything once ----------
      final userModel = localDataSource.getCachedUser();
      final userId = localDataSource.getUserId();
      final accessToken = localDataSource.getAccessToken();
      final refreshToken = localDataSource.getRefreshToken();
      final accessExpiresAt = localDataSource.getAccessTokenExpiresIn();
      final refreshExpiresAt = localDataSource.getRefreshTokenExpiresIn();

      // ---------- Print all pulled info ----------
      debugPrint('Pulled user: $userModel');
      debugPrint('Pulled userId: $userId');
      debugPrint('Pulled accessToken: $accessToken');
      debugPrint('Pulled accessExpiresAt: $accessExpiresAt');
      debugPrint('Pulled refreshToken: $refreshToken');
      debugPrint('Pulled refreshExpiresAt: $refreshExpiresAt');

      // ---------- Basic presence checks ----------
      if (userModel == null || userId == -1 || accessToken.isEmpty || accessExpiresAt == 0) {
        _logoutLocally();
        return false;
      }

      final now = DateTime.now().millisecondsSinceEpoch;
      final willExpireSoon = accessExpiresAt - now <= _kRefreshGrace.inMilliseconds;

      // ---------- 1) Access token still good ----------
      if (!willExpireSoon) {
        _userStore.value = userModel.toEntity();
        return true;
      }

      // ---------- 2) Need refresh ► validate refresh token ----------
      if (refreshToken.isEmpty || refreshExpiresAt == 0 || refreshExpiresAt <= now) {
        _logoutLocally();
        return false;
      }

      // ---------- 3) Attempt refresh ----------
      await refreshTokens(
        RefreshTokenDto(
          userId: userId,
          refreshToken: refreshToken,
          deviceId: await deviceInfo.getDeviceId(),
        ),
      );

      // Re-pull new tokens
      final newAccessExpiresAt = localDataSource.getAccessTokenExpiresIn();
      final newAccessToken = localDataSource.getAccessToken();

      final refreshSuccess = newAccessToken.isNotEmpty && newAccessExpiresAt - now > _kRefreshGrace.inMilliseconds;

      if (refreshSuccess) {
        _userStore.value = userModel.toEntity();
        return true;
      }

      // ---------- 4) Anything fails ► logout ----------
      _logoutLocally();
      return false;
    });
  }

  void _logoutLocally() {
    _userStore.value = null;
    localDataSource.removeCachedUser();
    localDataSource.removeTokens();
  }
}
