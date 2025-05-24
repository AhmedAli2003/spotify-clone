import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spotify_clone_app/core/constants/app_assets.dart';
import 'package:spotify_clone_app/core/theme/app_colors.dart';
import 'package:spotify_clone_app/features/home/views/widgets/library_view.dart';
import 'package:spotify_clone_app/features/home/views/widgets/songs_view.dart';
import 'package:spotify_clone_app/features/songs/views/widgets/music_slab.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState<int>(0);

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: selectedIndex.value,
            children: const [
              SongsView(),
              LibraryView(),
            ],
          ),
          const Positioned(
            bottom: 0,
            child: MusicSlab(),
          ),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: AppColors.backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              selectedIndex.value == 0 ? AppAssets.homeFilled : AppAssets.homeUnfilled,
              color: selectedIndex.value == 0 ? AppColors.whiteColor : AppColors.inactiveBottomBarItemColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppAssets.library,
              color: selectedIndex.value == 1 ? AppColors.whiteColor : AppColors.inactiveBottomBarItemColor,
            ),
            label: 'Library',
          ),
        ],
        currentIndex: selectedIndex.value,
        onTap: (index) => selectedIndex.value = index,
      ),
    );
  }
}
