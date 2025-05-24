import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/core/constants/app_urls.dart';
import 'package:spotify_clone_app/core/providers/dio_provider.dart';
import 'package:spotify_clone_app/features/songs/models/is_favorite_song_model.dart';
import 'package:spotify_clone_app/features/songs/models/paginated_songs_model.dart';
import 'package:spotify_clone_app/features/songs/models/song_model.dart';

part 'songs_api.g.dart';

@riverpod
SongsApi songsApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  return SongsApi(dio, baseUrl: AppUrls.baseUrl);
}

@RestApi(baseUrl: AppUrls.baseUrl)
abstract class SongsApi {
  factory SongsApi(Dio dio, {String baseUrl, ParseErrorLogger errorLogger}) = _SongsApi;

  @MultiPart()
  @POST(AppUrls.uploadSong)
  @Extra(AppUrls.requiresToken)
  Future<void> uploadSong(@Body() FormData formData);

  @GET(AppUrls.getSongs)
  @Extra(AppUrls.requiresToken)
  Future<PaginatedSongsModel> getSongs(@Queries() Map<String, dynamic> query);

  @POST(AppUrls.favoriteSong)
  @Extra(AppUrls.requiresToken)
  Future<void> favoriteSong(@Path('songId') int songId);

  @DELETE(AppUrls.unfavoriteSong)
  @Extra(AppUrls.requiresToken)
  Future<void> unfavoriteSong(@Path('songId') int songId);

  @GET(AppUrls.isFavoriteSong)
  @Extra(AppUrls.requiresToken)
  Future<IsFavoriteSongModel> isFavoriteSong(@Path('songId') int songId);

  @GET(AppUrls.getFavoriteSongs)
  @Extra(AppUrls.requiresToken)
  Future<List<SongModel>> getFavoriteSongs();
}
