import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/features/auth/models/user.dart';

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl();
});

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<void> cacheUser(UserModel user) async {
    // Implement caching logic here
  }

  @override
  Future<UserModel?> getCachedUser() async {
    // Implement retrieval logic here
    return null;
  }
}
