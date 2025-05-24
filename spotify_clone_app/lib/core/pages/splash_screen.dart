import 'package:flutter/material.dart';
import 'package:spotify_clone_app/core/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Center(
          child: FlutterLogo(
            size: 128,
          ),
        ),
      ),
    );
  }
}
