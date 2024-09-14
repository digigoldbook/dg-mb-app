import 'package:flutter/material.dart';

class FadeAnimation {
  late AnimationController controller;
  late Animation<double> animation;

  FadeAnimation(TickerProvider vsync) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 1),
    );

    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
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
