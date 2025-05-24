import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/core/errors/failure.dart';
import 'package:spotify_clone_app/core/providers/shared_preferences_provider.dart';
import 'package:spotify_clone_app/core/utils/device_info.dart';
import 'package:spotify_clone_app/core/utils/in_memory_store.dart';
import 'package:spotify_clone_app/features/auth/dtos/login_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/logout_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/refresh_token_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/register_dto.dart';
import 'package:spotify_clone_app/features/auth/models/user.dart';
import 'package:spotify_clone_app/features/auth/repositories/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  late final AuthRepository _repo;
  late final DeviceInfo _deviceInfo;

  @override
  FutureOr<User?> build() {
    _repo = ref.watch(authRepositoryProvider);
    _deviceInfo = ref.watch(deviceInfoProvider);
    return null; // no user initially
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = await _repo.login(
        LoginDto(
          email: email,
          password: password,
          deviceId: await _deviceInfo.getDeviceId(),
          deviceInfo: await _deviceInfo.getDeviceInfo(),
        ),
      );
      return user;
    });
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = await _repo.signup(
        RegisterDto(
          name: name,
          email: email,
          password: password,
          deviceId: await _deviceInfo.getDeviceId(),
          deviceInfo: await _deviceInfo.getDeviceInfo(),
        ),
      );
      return user;
    });
  }

  Future<void> refreshTokens() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // Check if the user is logged in
      final userId = ref.read(sharedPreferencesManagerProvider).getUserId();
      if (userId == null) {
        _repo.userStore.value = null;
        throw const Failure('User is not logged in');
      }

      // Check if the refresh token is available
      final refreshToken = ref.read(sharedPreferencesManagerProvider).getRefreshToken();
      if (refreshToken == null) {
        _repo.userStore.value = null;
        throw const Failure('Refresh token is not available');
      }

      await _repo.refreshTokens(
        RefreshTokenDto(
          userId: userId,
          refreshToken: refreshToken,
          deviceId: await _deviceInfo.getDeviceId(),
        ),
      );

      return null;
    });
  }

  void logout() async {
    state = const AsyncData(null);

    if (state.hasError) {
      return;
    }

    await AsyncValue.guard(() async {
      debugPrint('Logging out...');
      // Check if the user is logged in
      final userId = ref.read(sharedPreferencesManagerProvider).getUserId();
      if (userId == null) {
        _repo.userStore.value = null;
        debugPrint('User is not logged in');
        throw const Failure('User is not logged in');
      }

      debugPrint('HERE');

      await _repo.logout(
        LogoutDto(
          userId: userId,
          deviceId: await _deviceInfo.getDeviceId(),
        ),
      );

      debugPrint('User logged out successfully');
    });
  }
}

@riverpod
InMemoryStore<User?> userStore(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.userStore;
}
