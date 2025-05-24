// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongModel _$SongModelFromJson(Map<String, dynamic> json) => SongModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      artist: json['artist'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
      user: json['user'] == null
          ? null
          : SongUserModel.fromJson(json['user'] as Map<String, dynamic>),
      color: json['color'] as String?,
    );

Map<String, dynamic> _$SongModelToJson(SongModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'artist': instance.artist,
      'color': instance.color,
      'thumbnailUrl': instance.thumbnailUrl,
      'audioUrl': instance.audioUrl,
      'user': instance.user,
    };
