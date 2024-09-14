import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../components/animation/fade_animation.dart';
import '../../../components/widget/btn_widget.dart';
import '../../../components/widget/text_field_widget.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with TickerProviderStateMixin {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNo = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isHidden = true;

  late FadeAnimation _fullNameFadeAnimation;
  late FadeAnimation _emailFadeAnimation;
  late FadeAnimation _phoneNoFadeAnimation;
  late FadeAnimation _passwordFadeAnimation;
  late FadeAnimation _buttonFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize fade animations
    _fullNameFadeAnimation = FadeAnimation(this);
    _emailFadeAnimation = FadeAnimation(this);
    _phoneNoFadeAnimation = FadeAnimation(this);
    _passwordFadeAnimation = FadeAnimation(this);
    _buttonFadeAnimation = FadeAnimation(this);

    // Start animations in sequence
    _fullNameFadeAnimation.start();
    _fullNameFadeAnimation.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _emailFadeAnimation.start();
        _emailFadeAnimation.controller.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _phoneNoFadeAnimation.start();
            _phoneNoFadeAnimation.controller.addStatusListener((status) {
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
        });
      }
    });
  }

  @override
  void dispose() {
    _fullNameFadeAnimation.dispose();
    _emailFadeAnimation.dispose();
    _phoneNoFadeAnimation.dispose();
    _passwordFadeAnimation.dispose();
    _buttonFadeAnimation.dispose();
    _fullName.dispose();
    _email.dispose();
    _phoneNo.dispose();
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
            opacity: _fullNameFadeAnimation.animation,
            child: TextFieldWidget(
              inputType: TextInputType.name,
              controller: _fullName,
              hintText: 'Full Name',
              prefixIcon: Icons.person,
            ),
          ),
          const Gap(16),
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
            opacity: _phoneNoFadeAnimation.animation,
            child: TextFieldWidget(
              inputType: TextInputType.phone,
              controller: _phoneNo,
              hintText: 'Phone Number',
              prefixIcon: Icons.phone,
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
              prefixIcon: Icons.lock,
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
          const Gap(24),
          FadeTransition(
            opacity: _buttonFadeAnimation.animation,
            child: BtnWidget(
              btnText: "Sign Up",
              onTap: () => context.pushReplacementNamed("main"),
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
