import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/widget/txt_widget.dart';

import '../../components/widget/app_bar.dart';

import '../widgets/profile_user_info.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          customAppBar(context),
          const ProfileUserInfo(),
          SwitchListTile(
            value: false,
            onChanged: (bool value) {},
            title: const TxtWidget(
              strText: "Theme",
              style: TxtStyle.rg,
            ),
          )
        ],
      ),
    );
  }
}
