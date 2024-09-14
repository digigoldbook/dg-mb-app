import 'package:flutter/material.dart';

import '../../components/animation/fade_animation.dart';
import '../../components/animation/slide_animation.dart';
import '../widget/background_image_widget.dart';
import '../widget/image_color_overlay.dart';
import '../widget/welcome_bottom_widget.dart';

class WelComePage extends StatefulWidget {
  const WelComePage({super.key});

  @override
  State<WelComePage> createState() => _WelComePageState();
}

class _WelComePageState extends State<WelComePage>
    with TickerProviderStateMixin {
  late SlideAnimation _slideAnimation;
  late FadeAnimation _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _slideAnimation = SlideAnimation(this);
    _fadeAnimation = FadeAnimation(this);

    _slideAnimation.start();

    _slideAnimation.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeAnimation.start();
      }
    });
  }

  @override
  void dispose() {
    _slideAnimation.dispose();
    _fadeAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          const BackGroundImageWidget(),
          // Gradient overlay
          const ImageColorOverlay(),
          // Animated content
          WelcomeBottomWidget(
            fadeAnimation: _fadeAnimation.animation,
            slideAnimation: _slideAnimation.animation,
          ),
        ],
      ),
    );
  }
}
