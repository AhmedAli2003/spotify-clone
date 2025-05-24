class IsFavoriteSongModel {
  final bool isFavorited;

  const IsFavoriteSongModel({
    required this.isFavorited,
  });

  factory IsFavoriteSongModel.fromJson(Map<String, dynamic> json) {
    return IsFavoriteSongModel(
      isFavorited: json['isFavorited'] as bool,
    );
  }
}
