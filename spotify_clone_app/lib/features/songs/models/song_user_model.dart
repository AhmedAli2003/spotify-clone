import 'package:json_annotation/json_annotation.dart';

part 'song_user_model.g.dart';

@JsonSerializable()
class SongUserModel {
  final int? id;
  final String? name;

  const SongUserModel({
    this.id,
    this.name,
  });

  factory SongUserModel.fromJson(Map<String, dynamic> json) => _$SongUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$SongUserModelToJson(this);
}

class SongUser {
  final int id;
  final String name;

  const SongUser({
    required this.id,
    required this.name,
  });

  const SongUser.empty() : id = -1, name = 'undefined';
}
