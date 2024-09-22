import 'package:flutter/material.dart';

import '../config/app_images.dart';
import 'txt_widget.dart';

PreferredSizeWidget customAppBar({String? title}) {
  return AppBar(
    title: TxtWidget(
      strText: title ?? "Digi Gold Book",
      style: TxtStyle.mdb,
    ),
    centerTitle: true,
    actions: [
      Container(
        margin: const EdgeInsets.only(right: 16),
        child: Image.asset(
          AppImages.instance.dashboardPng,
          width: 24,
        ),
      )
    ],
  );
}
