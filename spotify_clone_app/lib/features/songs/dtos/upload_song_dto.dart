import 'package:dio/dio.dart';

class UploadSongDto {
  final MultipartFile audioMultipart;
  final MultipartFile imageMultipart;
  final String name;
  final String artist;
  final String color;

  const UploadSongDto({
    required this.audioMultipart,
    required this.imageMultipart,
    required this.name,
    required this.artist,
    required this.color,
  });

  /// Convert to FormData to be used in Retrofit
  FormData toFormData() {
    return FormData.fromMap({
      'files': [audioMultipart, imageMultipart],
      'name': name,
      'artist': artist,
      'color': color,
    });
  }
}
