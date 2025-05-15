import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/router/app_routes.dart';
import 'package:spotify_clone_app/core/router/go_router_refresh_rx.dart';
import 'package:spotify_clone_app/features/auth/controllers/auth_controller.dart';
import 'package:spotify_clone_app/features/auth/views/pages/login_page.dart';
import 'package:spotify_clone_app/features/auth/views/pages/sign_up_page.dart';
import 'package:spotify_clone_app/features/home/views/pages/home_page.dart';

final appRouterProvider = Provider<GoRouter>(
  (ref) {
    final userStore = ref.watch(userStoreProvider);
    final refreshNotifier = GoRouterRefreshRx(userStore.stream);

    return GoRouter(
      initialLocation: AppRoutes.home,
      routes: [
        GoRoute(
          path: AppRoutes.home,
          name: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.login,
          name: AppRoutes.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.signup,
          name: AppRoutes.signup,
          builder: (context, state) => const SignUpPage(),
        ),
      ],
      refreshListenable: refreshNotifier,
      redirect: (_, state) {

        print('Full path: ${state.fullPath}');
        print('Path: ${state.path}');
        print('Uri: ${state.uri.toString()}');
        print('toFilePath: ${state.uri.toFilePath()}');
        print('matchedLocation: ${state.matchedLocation}');

        final isLoggedIn = userStore.value != null;
        final isLoggingIn = state.fullPath == AppRoutes.login || state.fullPath == AppRoutes.signup;

        if (!isLoggedIn && !isLoggingIn) return AppRoutes.login;
        if (isLoggedIn && isLoggingIn) return AppRoutes.home;

        return null;
      },
    );
  },
);
