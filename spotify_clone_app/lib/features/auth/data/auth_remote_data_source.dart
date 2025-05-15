import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/features/auth/data/auth_api.dart';
import 'package:spotify_clone_app/features/auth/dtos/login_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/register_dto.dart';
import 'package:spotify_clone_app/features/auth/models/user.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final api = ref.watch(authApiProvider);
  return AuthRemoteDataSourceImpl(api);
});

abstract class AuthRemoteDataSource {
  Future<UserModel> login(LoginDto loginDto);
  Future<UserModel> signup(RegisterDto registerDto);
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
}
