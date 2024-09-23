import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/widget/txt_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../components/animation/fade_animation.dart';
import '../../../components/widget/btn_widget.dart';
import '../../../components/widget/text_field_widget.dart';
import '../bloc/sign_in_bloc.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> with TickerProviderStateMixin {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isHidden = true;

  late FadeAnimation _emailFadeAnimation;
  late FadeAnimation _passwordFadeAnimation;
  late FadeAnimation _buttonFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize fade animations
    _emailFadeAnimation = FadeAnimation(this);
    _passwordFadeAnimation = FadeAnimation(this);
    _buttonFadeAnimation = FadeAnimation(this);

    // Start animations in sequence
    _emailFadeAnimation.start();
    _emailFadeAnimation.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _passwordFadeAnimation.start();
        _passwordFadeAnimation.controller.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _buttonFadeAnimation.start();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _emailFadeAnimation.dispose();
    _passwordFadeAnimation.dispose();
    _buttonFadeAnimation.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeTransition(
            opacity: _emailFadeAnimation.animation,
            child: TextFieldWidget(
              inputType: TextInputType.emailAddress,
              controller: _email,
              hintText: 'Email',
              prefixIcon: Icons.mail,
            ),
          ),
          const Gap(16),
          FadeTransition(
            opacity: _passwordFadeAnimation.animation,
            child: TextFieldWidget(
              inputType: TextInputType.text,
              isObscureText: _isHidden,
              controller: _password,
              hintText: 'Password',
              prefixIcon: Icons.password,
              suffix: IconButton(
                onPressed: () {
                  setState(() {
                    _isHidden = !_isHidden;
                  });
                },
                icon: Icon(
                  _isHidden ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () => context.pushNamed("reset-password"),
            child: const TxtWidget(
              strText: "Forgot Password",
              style: TxtStyle.rg,
            ),
          ),
          const Gap(24),
          FadeTransition(
            opacity: _buttonFadeAnimation.animation,
            child: BtnWidget(
              btnText: "Sign in",
              onTap: () {
                context.read<SignInBloc>().add(
                      SignInSubmitForm(
                        email: _email.text,
                        password: _password.text,
                      ),
                    );
              },
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
