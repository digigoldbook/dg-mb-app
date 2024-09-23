import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/app_images.dart';
import 'txt_widget.dart';

PreferredSizeWidget customAppBar(BuildContext ctx, {String? title}) {
  return AppBar(
    title: TxtWidget(
      strText: title ?? "Digi Gold Book",
      style: TxtStyle.mdb,
    ),
    centerTitle: true,
    actions: [
      InkWell(
        onTap: () => showModalBottomSheet(
            context: ctx,
            builder: (context) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ListTile(
                    onTap: () => context.pushNamed("feedback"),
                    leading: const Icon(Icons.feedback),
                    title: const Text("Feedback"),
                  ),
                ],
              );
            }),
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          child: Image.asset(
            AppImages.instance.dashboardPng,
            width: 24,
          ),
        ),
      )
    ],
  );
}
