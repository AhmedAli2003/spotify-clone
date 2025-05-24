// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutDto _$LogoutDtoFromJson(Map<String, dynamic> json) => LogoutDto(
      userId: (json['userId'] as num).toInt(),
      deviceId: json['deviceId'] as String,
    );

Map<String, dynamic> _$LogoutDtoToJson(LogoutDto instance) => <String, dynamic>{
      'userId': instance.userId,
      'deviceId': instance.deviceId,
    };
