import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/core/providers/shared_preferences_provider.dart';
import 'package:spotify_clone_app/features/auth/models/tokens_model.dart';
import 'package:spotify_clone_app/features/auth/models/user.dart';

part 'auth_local_data_source.g.dart';

@riverpod
AuthLocalDataSource authLocalDataSource(Ref ref) {
  final sharedPreferencesManager = ref.watch(sharedPreferencesManagerProvider);
  return AuthLocalDataSourceImpl(
    sharedPreferencesManager: sharedPreferencesManager,
  );
}

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  UserModel? getCachedUser();
  Future<void> removeCachedUser();
  Future<void> cacheTokens(TokensModel tokens);
  String getAccessToken();
  String getRefreshToken();
  Future<void> removeAccessToken();
  Future<void> removeTokens();
  Future<void> removeUser();
  int getAccessTokenExpiresIn();
  int getRefreshTokenExpiresIn();
  int getUserId();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferencesManager sharedPreferencesManager;

  AuthLocalDataSourceImpl({required this.sharedPreferencesManager});

  @override
  Future<void> cacheUser(UserModel user) async {
    await sharedPreferencesManager.cacheUser(user);
  }

  @override
  UserModel? getCachedUser() {
    return sharedPreferencesManager.getCachedUserJson();
  }

  @override
  Future<void> removeCachedUser() {
    return sharedPreferencesManager.clearCachedUser();
  }

  @override
  Future<void> cacheTokens(TokensModel tokens) {
    return sharedPreferencesManager.setTokens(tokens);
  }

  @override
  String getAccessToken() {
    return sharedPreferencesManager.getAccessToken() ?? '';
  }

  @override
  int getAccessTokenExpiresIn() {
    return sharedPreferencesManager.getAccessTokenExpiresIn() ?? 0;
  }

  @override
  String getRefreshToken() {
    return sharedPreferencesManager.getRefreshToken() ?? '';
  }

  @override
  int getRefreshTokenExpiresIn() {
    return sharedPreferencesManager.getRefreshTokenExpiresIn() ?? 0;
  }

  @override
  Future<void> removeAccessToken() {
    return sharedPreferencesManager.removeAccessToken();
  }

  @override
  Future<void> removeTokens() {
    return sharedPreferencesManager.removeTokens();
  }

  @override
  Future<void> removeUser() {
    return sharedPreferencesManager.clearCachedUser();
  }

  @override
  int getUserId() {
    return sharedPreferencesManager.getUserId() ?? -1;
  }
}
