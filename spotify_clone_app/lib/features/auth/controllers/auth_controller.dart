import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/core/utils/in_memory_store.dart';
import 'package:spotify_clone_app/features/auth/dtos/login_dto.dart';
import 'package:spotify_clone_app/features/auth/dtos/register_dto.dart';
import 'package:spotify_clone_app/features/auth/models/user.dart';
import 'package:spotify_clone_app/features/auth/repositories/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  late final AuthRepository _repo;

  @override
  FutureOr<User?> build() {
    _repo = ref.watch(authRepositoryProvider);
    return null; // no user initially
  }

  Future<void> login(LoginDto dto) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = await _repo.login(dto);
      return user;
    });
  }

  Future<void> signup(RegisterDto dto) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = await _repo.signup(dto);
      return user;
    });
  }

  void logout() {
    state = const AsyncData(null);
  }

  Stream<User?> get userStream => _repo.userStream;
}

final userStoreProvider = Provider<InMemoryStore<User?>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.userStore;
});
