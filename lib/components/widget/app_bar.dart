import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../welcome_screen/cubit/locale_cubit.dart';
import '../config/app_images.dart';
import '../config/app_localization.dart';
import 'txt_widget.dart';

PreferredSizeWidget customAppBar(BuildContext ctx, {String? title}) {
  return AppBar(
    title: TxtWidget(
      strText: title ?? AppLocalizations.of(ctx)!.translate("appName"),
      style: TxtStyle.mdb,
    ),
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () => showModalBottomSheet(
            context: ctx,
            builder: (ctx) {
              final currentLocale = ctx.watch<LocaleCubit>().state.languageCode;

              return Padding(
                padding: const EdgeInsets.all(16.0), // Add padding
                child: Wrap(
                  children: [
                    ListTile(
                      onTap: () {
                        ctx.read<LocaleCubit>().switchLocale('ne');
                      },
                      title: TxtWidget(
                        strText: AppLocalizations.of(ctx)!.translate("nepali"),
                        style: TxtStyle.rg,
                      ),
                      trailing: currentLocale == 'ne'
                          ? const Icon(Icons.check, color: Colors.green)
                          : null, // Show check icon if selected
                    ),
                    ListTile(
                      onTap: () {
                        ctx.read<LocaleCubit>().switchLocale('en');
                      },
                      title: TxtWidget(
                        strText: AppLocalizations.of(ctx)!.translate("english"),
                        style: TxtStyle.rg,
                      ),
                      trailing: currentLocale == 'en'
                          ? const Icon(Icons.check, color: Colors.green)
                          : null, // Show check icon if selected
                    ),
                  ],
                ),
              );
            }),
        icon: const Icon(Icons.language),
      ),
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
