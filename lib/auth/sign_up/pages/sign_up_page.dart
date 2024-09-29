import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../components/config/app_localization.dart';
import '../../../components/utils/toast_utils.dart';
import '../../../components/widget/txt_widget.dart';
import '../../widgets/auth_footer.dart';
import '../../widgets/auth_header.dart';
import '../bloc/sign_up_bloc.dart';
import '../widgets/sign_up_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpBloc(),
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpFailure) {
              showToast(state.error);
            }
            if (state is SignUpSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.pushReplacementNamed("sign-in");
              });
            }
          },
          child: BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              AuthHeader(
                                strTitle: AppLocalizations.of(context)!
                                    .translate("signUp"),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: TxtWidget(
                                  strText: "Welcome Back",
                                  style: TxtStyle.mdb,
                                ),
                              ),
                              const SignUpForm(),
                            ],
                          ),
                          AuthFooter(
                            leadingTxt: "Already have an account?",
                            trailingTxt: "Go Back",
                            path: () => context.pushNamed("sign-in"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (state is SignUpLoading)
                    Container(
                      color: Colors.black
                          .withOpacity(0.5), // Semi-transparent overlay
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
