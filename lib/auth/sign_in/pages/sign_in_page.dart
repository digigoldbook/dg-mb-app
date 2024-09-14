import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const AuthHeader(
                          strTitle: "Sign In",
                        ),
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: TxtWidget(
                              strText: "Welcome Back", style: TxtStyle.mdb),
                        ),
                        BlocProvider(
                          create: (context) => SignInBloc(),
                          child: BlocListener<SignInBloc, SignInState>(
                            listener: (context, state) {
                              if (state is SignInLoading) {
                                setState(() {
                                  _isLoading = true;
                                });
                              }
                              if (state is SignInSuccess) {
                                context.pushReplacementNamed("auth-screen");
                              }
                              if (state is SignInError) {
                                setState(() {
                                  _isLoading = false;
                                });
                                showToast(state.strError);
                              }
                            },
                            child: const SignInForm(),
                          ),
                        ),
                      ],
                    ),
                    AuthFooter(
                      leadingTxt: "Don't have an account?",
                      trailingTxt: " Create Account",
                      path: () => context.pushNamed("sign-up"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
