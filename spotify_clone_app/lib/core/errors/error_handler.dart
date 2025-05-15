import 'dart:io';
import 'package:spotify_clone_app/core/errors/api_exception.dart';
import 'package:spotify_clone_app/core/errors/app_exception.dart';
import 'package:spotify_clone_app/core/errors/failure.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  const ErrorHandler._();

  static Failure handleError(Object error) {
    if (error is DioException) {
      final response = error.response;
      if (response?.data is Map<String, dynamic>) {
        final data = response!.data;
        return Failure(
          data['message'] ?? 'Unexpected server error',
          statusCode: response.statusCode,
        );
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const Failure('Connection timed out. Please try again.');
        case DioExceptionType.badCertificate:
          return const Failure('Bad certificate from server.');
        case DioExceptionType.connectionError:
          return const Failure('No internet connection.');
        case DioExceptionType.cancel:
          return const Failure('Request was cancelled.');
        case DioExceptionType.unknown:
        default:
          return const Failure('Something went wrong. Please try again.');
      }
    } else if (error is SocketException) {
      return const Failure('No internet connection.');
    } else if (error is FormatException) {
      return const Failure('Invalid response format.');
    } else if (error is ApiException) {
      return Failure(error.message, statusCode: error.statusCode);
    } else if (error is AppException) {
      return Failure(error.message, statusCode: error.statusCode);
    }
    return const Failure('Unexpected error occurred.');
  }
}
