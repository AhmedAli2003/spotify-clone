import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_clone_app/core/constants/app_keys.dart';
import 'package:spotify_clone_app/core/utils/date_helper.dart';
import 'package:spotify_clone_app/features/auth/models/tokens_model.dart';
import 'package:spotify_clone_app/features/auth/models/user.dart';

part 'shared_preferences_provider.g.dart';

@riverpod
SharedPreferencesManager sharedPreferencesManager(Ref ref) {
  throw UnimplementedError();
}

class SharedPreferencesManager {
  final SharedPreferences _prefs;

  const SharedPreferencesManager(this._prefs);

  Future<void> setAccessToken(String token, String accessTokenExpiresIn) async {
    await _prefs.setString(AppKeys.accessToken, token);
    await _prefs.setInt(
      AppKeys.accessTokenExpiresIn,
      DateHelper.getExpirationTimestamp(accessTokenExpiresIn),
    );
  }

  Future<void> setTokens(TokensModel tokens) async {
    await _prefs.setString(AppKeys.accessToken, tokens.accessToken);
    await _prefs.setString(AppKeys.refreshToken, tokens.refreshToken);
    await _prefs.setInt(
      AppKeys.accessTokenExpiresIn,
      DateHelper.getExpirationTimestamp(tokens.accessTokenExpiresIn),
    );
    await _prefs.setInt(
      AppKeys.refreshTokenExpiresIn,
      DateHelper.getExpirationTimestamp(tokens.refreshTokenExpiresIn),
    );
  }

  String? getAccessToken() => _prefs.getString(AppKeys.accessToken);
  int? getAccessTokenExpiresIn() => _prefs.getInt(AppKeys.accessTokenExpiresIn);
  String? getRefreshToken() => _prefs.getString(AppKeys.refreshToken);
  int? getRefreshTokenExpiresIn() => _prefs.getInt(AppKeys.refreshTokenExpiresIn);

  Future<void> removeAccessToken() async {
    await _prefs.remove(AppKeys.accessToken);
    await _prefs.remove(AppKeys.accessTokenExpiresIn);
  }

  Future<void> removeTokens() async {
    await _prefs.remove(AppKeys.accessToken);
    await _prefs.remove(AppKeys.refreshToken);
    await _prefs.remove(AppKeys.accessTokenExpiresIn);
    await _prefs.remove(AppKeys.refreshTokenExpiresIn);
  }

  Future<void> cacheUser(UserModel user) async {
    await _prefs.setString(AppKeys.user, jsonEncode(user.toJson()));
    await _prefs.setInt(AppKeys.userId, user.id ?? -1);
    await _prefs.setString(AppKeys.userEmail, user.email ?? '');
    await _prefs.setString(AppKeys.userName, user.name ?? '');
  }

  UserModel? getCachedUserJson() {
    final userJson = _prefs.getString(AppKeys.user);
    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  int? getUserId() => _prefs.getInt(AppKeys.userId);

  Future<void> clearCachedUser() async {
    await _prefs.remove(AppKeys.user);
    await _prefs.remove(AppKeys.userId);
    await _prefs.remove(AppKeys.userEmail);
    await _prefs.remove(AppKeys.userName);
    await removeTokens();
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
