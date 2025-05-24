import 'package:json_annotation/json_annotation.dart';

part 'songs_meta_model.g.dart';

@JsonSerializable()
class SongsMetaModel {
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPages;

  const SongsMetaModel({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory SongsMetaModel.fromJson(Map<String, dynamic> json) => _$SongsMetaModelFromJson(json);
  Map<String, dynamic> toJson() => _$SongsMetaModelToJson(this);
}

class SongsMeta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  const SongsMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  const SongsMeta.empty()
      : total = 0,
        page = 1,
        limit = 10,
        totalPages = 0;
}
