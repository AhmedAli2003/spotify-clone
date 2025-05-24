// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenDto _$RefreshTokenDtoFromJson(Map<String, dynamic> json) =>
    RefreshTokenDto(
      userId: (json['userId'] as num).toInt(),
      refreshToken: json['refreshToken'] as String,
      deviceId: json['deviceId'] as String,
    );

Map<String, dynamic> _$RefreshTokenDtoToJson(RefreshTokenDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'refreshToken': instance.refreshToken,
      'deviceId': instance.deviceId,
    };
