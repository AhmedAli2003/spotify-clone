import 'package:json_annotation/json_annotation.dart';

part 'tokens_model.g.dart';

@JsonSerializable()
class TokensModel {
  final String accessToken;
  final String refreshToken;
  final String accessTokenExpiresIn;
  final String refreshTokenExpiresIn;

  const TokensModel({
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpiresIn,
    required this.refreshTokenExpiresIn,
  });

  factory TokensModel.fromJson(Map<String, dynamic> json) => _$TokensModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokensModelToJson(this);

  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(covariant TokensModel other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.accessTokenExpiresIn == accessTokenExpiresIn &&
        other.refreshTokenExpiresIn == refreshTokenExpiresIn;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^ refreshToken.hashCode ^ accessTokenExpiresIn.hashCode ^ refreshTokenExpiresIn.hashCode;
  }
}
