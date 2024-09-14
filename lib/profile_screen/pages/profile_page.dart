import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../auth/sign_in/hive/token_storage.dart';
import '../../components/widget/app_bar.dart';
import '../../components/widget/btn_widget.dart';
import '../../components/widget/txt_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          customAppBar(),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AvatarGlow(
                  glowColor: Colors.green,
                  glowRadiusFactor: sqrt(0.05),
                  child: const Material(
                    elevation: 1,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                    ),
                  ),
                ),
                const Gap(16),
                const TxtWidget(
                  strText: "Abishek Khanal",
                  style: TxtStyle.mdb,
                ),
                const Gap(24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BtnWidget(
                      btnText: "Contact",
                      onTap: () {},
                    ),
                    const Gap(16),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffD1E9F6),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => TokenStorage.clearTokens().then(
                            (_) => context.pushReplacementNamed("auth-screen")),
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
