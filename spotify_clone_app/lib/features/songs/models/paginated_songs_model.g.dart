// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_songs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedSongsModel _$PaginatedSongsModelFromJson(Map<String, dynamic> json) =>
    PaginatedSongsModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SongModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : SongsMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaginatedSongsModelToJson(
        PaginatedSongsModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };
