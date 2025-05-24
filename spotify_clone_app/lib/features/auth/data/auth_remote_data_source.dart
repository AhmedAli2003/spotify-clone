import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/features/auth/data/auth_api.dart';
import 'package:spotify_clone_app/features/auth/dtos/login_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/logout_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/refresh_token_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/register_dto.dart';
import 'package:spotify_clone_app/features/auth/models/tokens_model.dart';
import 'package:spotify_clone_app/features/auth/models/user.dart';

part 'auth_remote_data_source.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final api = ref.watch(authApiProvider);
  return AuthRemoteDataSourceImpl(api);
}

abstract class AuthRemoteDataSource {
  Future<UserModel> login(LoginDto loginDto);
  Future<UserModel> signup(RegisterDto registerDto);
  Future<TokensModel> refreshTokens(RefreshTokenDto body);
  Future<void> logout(LogoutDto body);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApi api;

  AuthRemoteDataSourceImpl(this.api);

  @override
  Future<UserModel> login(LoginDto loginDto) {
    return api.login(loginDto);
  }

  @override
  Future<UserModel> signup(RegisterDto registerDto) {
    return api.register(registerDto);
  }

  @override
  Future<TokensModel> refreshTokens(RefreshTokenDto body) {
    return api.refresh(body);
  }

  @override
  Future<void> logout(LogoutDto body) {
    return api.logout(body);
  }
}
