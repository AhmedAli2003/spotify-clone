import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/app/app.dart';
import 'package:spotify_clone_app/core/errors/failure.dart';
import 'package:spotify_clone_app/core/pages/error_screen.dart';
import 'package:spotify_clone_app/core/pages/splash_screen.dart';
import 'package:spotify_clone_app/features/auth/repositories/auth_repository.dart';

final authBootstrapProvider = FutureProvider<void>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  final authRepo = ref.watch(authRepositoryProvider);
  final success = await authRepo.ensureTokensValid();
  debugPrint('Bootstrap: $success');
});

class SplashBootstrap extends ConsumerWidget {
  const SplashBootstrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrap = ref.watch(authBootstrapProvider);

    return bootstrap.when(
      loading: () => const SplashScreen(),
      error: (e, st) {
        debugPrint('StackTrace: $st');
        if (e is Failure) {
          return ErrorScreen(message: e.message);
        }
        return ErrorScreen(message: e.toString());
      },
      data: (_) => const SpotifyClone(), // now go to router etc.
    );
  }
}
