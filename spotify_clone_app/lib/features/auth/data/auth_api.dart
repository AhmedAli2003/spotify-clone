import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotify_clone_app/core/constants/app_urls.dart';
import 'package:spotify_clone_app/core/providers/dio_provider.dart';
import 'package:spotify_clone_app/features/auth/dtos/login_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/register_dto.dart';
import 'package:spotify_clone_app/features/auth/models/user.dart';

part 'auth_api.g.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthApi(dio, baseUrl: AppUrls.baseUrl);
});

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/login')
  Future<UserModel> login(@Body() LoginDto body);

  @POST('/register')
  Future<UserModel> register(@Body() RegisterDto body);
}
