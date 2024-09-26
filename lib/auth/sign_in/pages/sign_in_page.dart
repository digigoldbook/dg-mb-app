import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../components/config/app_localization.dart';
import '../../../components/utils/toast_utils.dart';
import '../../../components/widget/txt_widget.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_header.dart';
import '../bloc/sign_in_bloc.dart';
import '../widgets/sign_in_form.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignInBloc(),
        child: BlocListener<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInError) {
              showToast(state.strError);
            }
            if (state is SignInSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.pushReplacementNamed("main");
                showToast("Successfully Loggedin");
              });
            }
          },
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      AuthHeader(
                        strTitle:
                            AppLocalizations.of(context)!.translate("signIn"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TxtWidget(
                          strText: AppLocalizations.of(context)!
                              .translate("welcome"),
                          style: TxtStyle.mdb,
                        ),
                      ),
                      BlocBuilder<SignInBloc, SignInState>(
                        builder: (context, state) {
                          if (state is SignInLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return const SignInForm();
                        },
                      ),
                    ],
                  ),
                  // Uncomment and implement AuthFooter if needed
                  AuthFooter(
                    leadingTxt: AppLocalizations.of(context)!
                        .translate("doNotHaveAccount"),
                    trailingTxt: AppLocalizations.of(context)!
                        .translate("createAnAccount"),
                    path: () => context.pushNamed("sign-up"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
