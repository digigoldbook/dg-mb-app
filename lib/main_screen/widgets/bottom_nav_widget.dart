import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/bottom_nav_cubit.dart';
import '../utils/bottom_nav_items.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      height: 80,
      onTap: (int value) => context.read<BottomNavCubit>().currentIndex(value),
      activeIndex:
          (context.watch<BottomNavCubit>().state as BottomNavInitial).index,
      itemCount: bottomNavItems.length,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 16,
      rightCornerRadius: 16,
      notchMargin: 16,
      borderColor: Colors.black12,
      scaleFactor: 0.5,
      tabBuilder: (int index, bool isActive) => _bottomNavItem(index, isActive),
    );
  }

  Widget _bottomNavItem(int index, bool isActive) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xffD1E9F6) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          bottomNavItems[index]['image'],
        ),
      ),
    );
  }
}
