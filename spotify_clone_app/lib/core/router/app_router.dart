import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/core/router/app_routes.dart';
import 'package:spotify_clone_app/core/router/go_router_refresh_rx.dart';
import 'package:spotify_clone_app/features/auth/controllers/auth_controller.dart';
import 'package:spotify_clone_app/features/auth/views/pages/login_page.dart';
import 'package:spotify_clone_app/features/auth/views/pages/sign_up_page.dart';
import 'package:spotify_clone_app/features/home/views/pages/favorite_songs_page.dart';
import 'package:spotify_clone_app/features/home/views/pages/home_page.dart';
import 'package:spotify_clone_app/features/songs/views/pages/music_player_page.dart';
import 'package:spotify_clone_app/features/songs/views/pages/upload_song_page.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final userStore = ref.watch(userStoreProvider);
  final refreshNotifier = GoRouterRefreshRx(userStore.stream);

  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        pageBuilder: (context, state) => const NoTransitionPage(
          name: AppRoutes.home,
          child: HomePage(),
        ),
        routes: [
          GoRoute(
            path: AppRoutes.uploadSong,
            name: AppRoutes.uploadSong,
            pageBuilder: (context, state) => const NoTransitionPage(
              name: AppRoutes.uploadSong,
              child: UploadSongPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.favorites,
            name: AppRoutes.favorites,
            pageBuilder: (context, state) => const NoTransitionPage(
              name: AppRoutes.favorites,
              child: FavoriteSongsPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.musicPlayer,
            name: AppRoutes.musicPlayer,
            pageBuilder: (context, state) => CustomTransitionPage(
              name: AppRoutes.musicPlayer,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                final tween = Tween(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).chain(
                  CurveTween(
                    curve: Curves.easeIn,
                  ),
                );

                final offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
              child: const MusicPlayerPage(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.login,
        pageBuilder: (context, state) => const NoTransitionPage(
          name: AppRoutes.login,
          child: LoginPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.signup,
        name: AppRoutes.signup,
        pageBuilder: (context, state) => const NoTransitionPage(
          name: AppRoutes.signup,
          child: SignUpPage(),
        ),
      ),
    ],
    refreshListenable: refreshNotifier,
    redirect: (_, state) {
      final isLoggedIn = userStore.value != null;
      final isLoggingIn = state.fullPath == AppRoutes.login || state.fullPath == AppRoutes.signup;

      if (!isLoggedIn && !isLoggingIn) return AppRoutes.login;
      if (isLoggedIn && isLoggingIn) return AppRoutes.home;

      return null;
    },
  );
}
