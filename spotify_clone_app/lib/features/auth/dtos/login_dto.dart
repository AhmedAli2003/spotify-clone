import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginDto {
  final String email;
  final String password;
  final String deviceId;
  final String deviceInfo;

  LoginDto({
    required this.email,
    required this.password,
    required this.deviceId,
    required this.deviceInfo,
  });

  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);

  factory LoginDto.fromJson(Map<String, dynamic> json) => _$LoginDtoFromJson(json);
}
