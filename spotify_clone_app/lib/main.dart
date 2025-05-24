import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_clone_app/core/app/bootstrap.dart';
import 'package:spotify_clone_app/core/providers/shared_preferences_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final sharedPrefsManager = SharedPreferencesManager(prefs);

  final container = ProviderContainer(
    overrides: [
      sharedPreferencesManagerProvider.overrideWith((ref) => sharedPrefsManager),
    ],
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const SplashBootstrap(),
    ),
  );
}
