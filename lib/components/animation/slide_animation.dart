import 'package:flutter/material.dart';

class SlideAnimation {
  late AnimationController controller;
  late Animation<Offset> animation;

  SlideAnimation(TickerProvider vsync) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 1),
    );

    animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));
  }

  void start() {
    controller.forward();
  }

  void dispose() {
    controller.dispose();
  }
}
