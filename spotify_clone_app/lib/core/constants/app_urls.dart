class AppUrls {
  const AppUrls._();

  static const String baseUrl = 'http://192.168.0.113:3000';
  static const String login = '/auth/login';
  static const String signup = '/auth/sign-up';
  static const String logout = '/auth/logout';
  static const String refresh = '/auth/refresh';

  static const String uploadSong = '/songs/upload';
  static const String getSongs = '/songs';

  static const String favoriteSong = '/songs/favorite/{songId}';
  static const String unfavoriteSong = '/songs/unfavorite/{songId}';
  static const String isFavoriteSong = '/songs/is-favorited/{songId}';
  static const String getFavoriteSongs = '/songs/favorites';

  static const requiresToken = {'requiresToken': true};
}
