import 'package:json_annotation/json_annotation.dart';

part 'register_dto.g.dart';

@JsonSerializable()
class RegisterDto {
  final String name;
  final String email;
  final String password;
  final String deviceId;
  final String deviceInfo;

  RegisterDto({
    required this.name,
    required this.email,
    required this.password,
    required this.deviceId,
    required this.deviceInfo,
  });

  Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);

  factory RegisterDto.fromJson(Map<String, dynamic> json) => _$RegisterDtoFromJson(json);
}
