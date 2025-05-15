import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/errors/error_handler.dart';
import 'package:spotify_clone_app/core/extensions/mappers.dart';
import 'package:spotify_clone_app/core/utils/in_memory_store.dart';
import 'package:spotify_clone_app/features/auth/data/auth_local_data_source.dart';
import 'package:spotify_clone_app/features/auth/data/auth_remote_data_source.dart';
import 'package:spotify_clone_app/features/auth/dtos/login_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/register_dto.dart';
import 'package:spotify_clone_app/features/auth/models/user.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);

  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

/// Abstract repository interface
abstract class AuthRepository {
  Stream<User?> get userStream;
  InMemoryStore<User?> get userStore;
  Future<User> loadCachedUser();
  Future<User> login(LoginDto loginDto);
  Future<User> signup(RegisterDto registerDto);
  Future<void> logout();
}

/// Concrete implementation
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  final _userStore = InMemoryStore<User?>(null);

  @override
  Stream<User?> get userStream => _userStore.stream;

  User? get currentUser => _userStore.value;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User> login(LoginDto loginDto) async {
    try {
      final userModel = await remoteDataSource.login(loginDto);
      await localDataSource.cacheUser(userModel); // Optional: caching
      _userStore.value = userModel.toEntity();
      return userModel.toEntity(); // Convert to domain entity
    } catch (e, st) {
      debugPrint(st.toString());
      throw ErrorHandler.handleError(e);
    }
  }

  @override
  Future<User> signup(RegisterDto registerDto) async {
    try {
      final userModel = await remoteDataSource.signup(registerDto);
      await localDataSource.cacheUser(userModel); // Optional: caching
      _userStore.value = userModel.toEntity();
      return userModel.toEntity();
    } catch (e, st) {
      debugPrint(st.toString());
      throw ErrorHandler.handleError(e);
    }
  }

  @override
  Future<User> loadCachedUser() {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    _userStore.value = null;
    // TODO: clear cache
  }
  
  @override
  InMemoryStore<User?> get userStore => InMemoryStore<User?>(null);
}
