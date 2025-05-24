import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotify_clone_app/core/router/app_routes.dart';
import 'package:spotify_clone_app/features/auth/controllers/auth_controller.dart';

class LibraryView extends ConsumerWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).goNamed(AppRoutes.uploadSong);
            },
            child: Text('Go To Upload Page'),
          ),
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).goNamed(AppRoutes.favorites);
            },
            child: Text('Go To Favorites Page'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(authControllerProvider.notifier).logout();
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
