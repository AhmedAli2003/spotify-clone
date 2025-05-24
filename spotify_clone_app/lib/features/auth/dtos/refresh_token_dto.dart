import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_dto.g.dart';

@JsonSerializable()
class RefreshTokenDto {
  final int userId;
  final String refreshToken;
  final String deviceId;

  const RefreshTokenDto({
    required this.userId,
    required this.refreshToken,
    required this.deviceId,
  });

  Map<String, dynamic> toJson() => _$RefreshTokenDtoToJson(this);

  factory RefreshTokenDto.fromJson(Map<String, dynamic> json) => _$RefreshTokenDtoFromJson(json);
}
