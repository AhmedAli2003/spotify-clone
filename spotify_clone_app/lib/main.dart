import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/constants/app_constants.dart';
import 'package:spotify_clone_app/core/router/app_router.dart';
import 'package:spotify_clone_app/core/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: SpotifyClone(),
    ),
  );
}

class SpotifyClone extends ConsumerWidget {
  const SpotifyClone({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.darkThemeMode,
      routerConfig: router,
    );
  }
}
