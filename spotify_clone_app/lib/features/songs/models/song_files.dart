import 'dart:io';

import 'package:flutter/material.dart' show Color;

class SongFilesModel {
  final File? audioFile;
  final File? imageFile;
  final String? songName;
  final String? artist;
  final Color? color;

  const SongFilesModel({
    this.audioFile,
    this.imageFile,
    this.songName,
    this.artist,
    this.color,
  });

  SongFilesModel copyWith({
    File? audioFile,
    File? imageFile,
    String? songName,
    String? artist,
    Color? color,
  }) {
    return SongFilesModel(
      audioFile: audioFile ?? this.audioFile,
      imageFile: imageFile ?? this.imageFile,
      songName: songName ?? this.songName,
      artist: artist ?? this.artist,
      color: color ?? this.color,
    );
  }

  @override
  bool operator ==(covariant SongFilesModel other) {
    if (identical(this, other)) return true;

    return other.audioFile == audioFile &&
        other.imageFile == imageFile &&
        other.songName == songName &&
        other.artist == artist &&
        other.color == color;
  }

  @override
  int get hashCode => audioFile.hashCode ^ imageFile.hashCode ^ songName.hashCode ^ artist.hashCode ^ color.hashCode;
}

class SongFiles {
  final File audioFile;
  final File imageFile;
  final String songName;
  final String artist;
  final Color color;

  const SongFiles({
    required this.audioFile,
    required this.imageFile,
    required this.songName,
    required this.artist,
    required this.color,
  });

  @override
  bool operator ==(covariant SongFiles other) {
    if (identical(this, other)) return true;

    return other.audioFile == audioFile &&
        other.imageFile == imageFile &&
        other.songName == songName &&
        other.artist == artist &&
        other.color == color;
  }

  @override
  int get hashCode => audioFile.hashCode ^ imageFile.hashCode ^ songName.hashCode ^ artist.hashCode ^ color.hashCode;

  SongFiles copyWith({
    File? audioFile,
    File? imageFile,
    String? songName,
    String? artist,
    Color? color,
  }) {
    return SongFiles(
      audioFile: audioFile ?? this.audioFile,
      imageFile: imageFile ?? this.imageFile,
      songName: songName ?? this.songName,
      artist: artist ?? this.artist,
      color: color ?? this.color,
    );
  }
}
