import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}
