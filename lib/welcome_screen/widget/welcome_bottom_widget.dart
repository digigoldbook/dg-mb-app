import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/widget/txt_widget.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../components/config/app_localization.dart';
import '../../components/widget/btn_widget.dart';

class WelcomeBottomWidget extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final Animation<double> fadeAnimation;
  const WelcomeBottomWidget({
    super.key,
    required this.slideAnimation,
    required this.fadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlideTransition(
        position: slideAnimation,
        child: Container(
          width: double.infinity,
          height: 340,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: FadeTransition(
            opacity: fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                const Gap(16),
                TxtWidget(
                  strText: AppLocalizations.of(context)!.translate('welcome'),
                  style: TxtStyle.mdb,
                ),
                const Text(
                  "Welcome to Daily Log from the team of application. We would like to share our experience with you guys. This is one of the most feasible outcomes.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const Gap(16),
                BtnWidget(
                  width: double.infinity,
                  btnText: "Get Started",
                  onTap: () => context.pushReplacementNamed("sign-in"),
                ),
                const Gap(16),
                BtnWidget(
                  width: double.infinity,
                  btnText: AppLocalizations.of(context)!
                      .translate('createAnAccount'),
                  onTap: () => context.pushReplacementNamed("sign-up"),
                  isSolid: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
