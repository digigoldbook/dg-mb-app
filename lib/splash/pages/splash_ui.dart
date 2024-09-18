import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashUi extends StatelessWidget {
  const SplashUi({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: const Color(0xff7695FF),
      child: Lottie.asset("assets/lottie/waiting.json"),
    );
  }
}
