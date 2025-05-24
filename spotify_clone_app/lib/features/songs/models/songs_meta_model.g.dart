// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songs_meta_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongsMetaModel _$SongsMetaModelFromJson(Map<String, dynamic> json) =>
    SongsMetaModel(
      total: (json['total'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SongsMetaModelToJson(SongsMetaModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
      'totalPages': instance.totalPages,
    };
