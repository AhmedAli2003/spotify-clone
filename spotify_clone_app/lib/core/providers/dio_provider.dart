import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:spotify_clone_app/core/constants/app_urls.dart';

/// Base options for all requests
final baseOptions = BaseOptions(
  baseUrl: AppUrls.baseUrl,
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
  headers: {
    'Content-Type': 'application/json',
  },
);

/// Dio provider
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(baseOptions);

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
});
