import 'package:flutter/material.dart' show Color;
import 'package:json_annotation/json_annotation.dart';
import 'package:spotify_clone_app/features/songs/models/song_user_model.dart';

part 'song_model.g.dart';

@JsonSerializable()
class SongModel {
  final int? id;
  final String? name;
  final String? artist;
  final String? color;
  final String? thumbnailUrl;
  final String? audioUrl;
  final SongUserModel? user;

  const SongModel({
    this.id,
    this.name,
    this.artist,
    this.thumbnailUrl,
    this.audioUrl,
    this.user,
    this.color,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => _$SongModelFromJson(json);
  Map<String, dynamic> toJson() => _$SongModelToJson(this);
}

class Song {
  final int id;
  final String name;
  final String artist;
  final Color color;
  final String thumbnailUrl;
  final String audioUrl;
  final SongUser user;

  const Song({
    required this.id,
    required this.name,
    required this.artist,
    required this.thumbnailUrl,
    required this.audioUrl,
    required this.color,
    required this.user,
  });
}
