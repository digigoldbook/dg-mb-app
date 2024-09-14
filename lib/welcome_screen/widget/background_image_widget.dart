import 'package:flutter/material.dart';

import '../../components/config/app_images.dart';

class BackGroundImageWidget extends StatelessWidget {
  const BackGroundImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppImages.instance.welcomeBackground),
        ),
      ),
    );
  }
}
