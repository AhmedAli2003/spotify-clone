import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/core/constants/app_urls.dart';
import 'package:spotify_clone_app/core/providers/shared_preferences_provider.dart';

part 'dio_provider.g.dart';

/// Base options for all requests
final baseOptions = BaseOptions(
  baseUrl: AppUrls.baseUrl,
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
  headers: {
    'Content-Type': 'application/json',
  },
);

// Dio provider
@riverpod
Dio dio(Ref ref) {
  final sharedPreferencesManager = ref.watch(sharedPreferencesManagerProvider);

  final dio = Dio(baseOptions);

  dio.interceptors.add(
    AuthInterceptor(sharedPreferencesManager.getAccessToken),
  );

  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 100,
      ),
    );
  }

  return dio;
}

class AuthInterceptor extends Interceptor {
  final String? Function() getAccessToken;

  AuthInterceptor(this.getAccessToken);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Use a custom flag to check if token should be added
    final requiresAuth = options.extra['requiresToken'] == true;

    if (requiresAuth) {
      final token = getAccessToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }
}
