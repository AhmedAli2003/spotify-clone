import 'package:spotify_clone_app/features/auth/models/user.dart';

extension UserModelToUser on UserModel {
  User toEntity() {
    return User(
      id: id ?? -1,
      name: 'undefined',
      email: 'undefined',
    );
  }
}