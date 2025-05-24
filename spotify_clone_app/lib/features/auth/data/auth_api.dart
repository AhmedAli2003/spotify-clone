import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/core/constants/app_urls.dart';
import 'package:spotify_clone_app/core/providers/dio_provider.dart';
import 'package:spotify_clone_app/features/auth/dtos/login_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/logout_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/refresh_token_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/register_dto.dart';
import 'package:spotify_clone_app/features/auth/models/tokens_model.dart';
import 'package:spotify_clone_app/features/auth/models/user.dart';

part 'auth_api.g.dart';

@riverpod
AuthApi authApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  return AuthApi(dio, baseUrl: AppUrls.baseUrl);
}

@RestApi(baseUrl: AppUrls.baseUrl)
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl, ParseErrorLogger errorLogger}) = _AuthApi;

  @POST(AppUrls.login)
  Future<UserModel> login(@Body() LoginDto body);

  @POST(AppUrls.signup)
  Future<UserModel> register(@Body() RegisterDto body);

  @POST(AppUrls.refresh)
  Future<TokensModel> refresh(@Body() RefreshTokenDto body);

  @POST(AppUrls.logout)
  Future<void> logout(@Body() LogoutDto body);
}
