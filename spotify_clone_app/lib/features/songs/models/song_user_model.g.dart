// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongUserModel _$SongUserModelFromJson(Map<String, dynamic> json) =>
    SongUserModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SongUserModelToJson(SongUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
