import 'package:json_annotation/json_annotation.dart';

part 'logout_dto.g.dart';

@JsonSerializable()
class LogoutDto {
  final int userId;
  final String deviceId;

  const LogoutDto({
    required this.userId,
    required this.deviceId,
  });

  Map<String, dynamic> toJson() => _$LogoutDtoToJson(this);

  factory LogoutDto.fromJson(Map<String, dynamic> json) => _$LogoutDtoFromJson(json);
}
