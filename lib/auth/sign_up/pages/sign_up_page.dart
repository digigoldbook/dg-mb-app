import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../components/config/app_localization.dart';
import '../../../components/widget/txt_widget.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_header.dart';
import '../widgets/sign_up_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  AuthHeader(
                    strTitle: AppLocalizations.of(context)!.translate("signUp"),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child:
                        TxtWidget(strText: "Welcome Back", style: TxtStyle.mdb),
                  ),
                  const SignUpForm(),
                ],
              ),
              AuthFooter(
                leadingTxt: "Already have an account?",
                trailingTxt: " Go Back",
                path: () => context.pushNamed("sign-in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
