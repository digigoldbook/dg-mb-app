import 'package:flutter/material.dart';
import '../../components/animation/fade_animation.dart';
import '../../components/animation/slide_animation.dart';
import '../../components/widget/txt_widget.dart';

class AuthHeader extends StatefulWidget {
  final String strTitle;
  const AuthHeader({super.key, required this.strTitle});

  @override
  State<AuthHeader> createState() => _AuthHeaderState();
}

class _AuthHeaderState extends State<AuthHeader> with TickerProviderStateMixin {
  late FadeAnimation _iconFadeAnimation;
  late SlideAnimation _textSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animations
    _iconFadeAnimation = FadeAnimation(this);
    _textSlideAnimation = SlideAnimation(this);

    // Start the icon fade animation
    _iconFadeAnimation.start();

    // Start the slide animation
    _textSlideAnimation.start();
  }

  @override
  void dispose() {
    _iconFadeAnimation.dispose();
    _textSlideAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 32,
        top: 16,
      ),
      width: double.infinity,
      height: 250,
      decoration: const BoxDecoration(
        color: Color(0xff7695FF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Fade transition for the icon
          FadeTransition(
            opacity: _iconFadeAnimation.animation,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff9DBDFF),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
          // Slide transition for the "Sign In" text
          SlideTransition(
            position: _textSlideAnimation.animation,
            child: TxtWidget(
              strText: widget.strTitle,
              style: TxtStyle.xl,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
