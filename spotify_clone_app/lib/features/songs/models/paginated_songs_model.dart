import 'package:json_annotation/json_annotation.dart';
import 'package:spotify_clone_app/features/songs/models/song_model.dart';
import 'package:spotify_clone_app/features/songs/models/songs_meta_model.dart';

part 'paginated_songs_model.g.dart';

@JsonSerializable()
class PaginatedSongsModel {
  final List<SongModel>? data;
  final SongsMetaModel? meta;

  const PaginatedSongsModel({
    this.data,
    this.meta,
  });

  factory PaginatedSongsModel.fromJson(Map<String, dynamic> json) => _$PaginatedSongsModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaginatedSongsModelToJson(this);
}

class PaginatedSongs {
  final List<Song> data;
  final SongsMeta meta;

  const PaginatedSongs({
    required this.data,
    required this.meta,
  });
}
