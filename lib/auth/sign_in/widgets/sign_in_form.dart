import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../components/config/app_localization.dart';
import '../../../components/widget/btn_widget.dart';
import '../../../components/widget/text_field_widget.dart';
import '../../../components/widget/txt_widget.dart';
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

  late AnimationController _emailController;
  late AnimationController _passwordController;
  late AnimationController _forgotPasswordController;
  late AnimationController _buttonController;

  late Animation<double> _emailFade;
  late Animation<double> _passwordFade;
  late Animation<double> _forgotPasswordFade;
  late Animation<double> _buttonFade;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers and curves
    _emailController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _passwordController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _forgotPasswordController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Define fade animations
    _emailFade = CurvedAnimation(
      parent: _emailController,
      curve: Curves.easeIn,
    );
    _passwordFade = CurvedAnimation(
      parent: _passwordController,
      curve: Curves.easeIn,
    );
    _forgotPasswordFade = CurvedAnimation(
      parent: _forgotPasswordController,
      curve: Curves.easeIn,
    );
    _buttonFade = CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeIn,
    );

    // Start the animations in sequence
    _emailController.forward().then((_) {
      _passwordController.forward().then((_) {
        _forgotPasswordController.forward().then((_) {
          _buttonController.forward();
        });
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _forgotPasswordController.dispose();
    _buttonController.dispose();
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
            opacity: _emailFade,
            child: TextFieldWidget(
              inputType: TextInputType.emailAddress,
              controller: _email,
              hintText: AppLocalizations.of(context)!.translate("email"),
              prefixIcon: Icons.mail,
            ),
          ),
          const Gap(16),
          FadeTransition(
            opacity: _passwordFade,
            child: TextFieldWidget(
              inputType: TextInputType.text,
              isObscureText: _isHidden,
              controller: _password,
              hintText: AppLocalizations.of(context)!.translate("password"),
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
          FadeTransition(
            opacity: _forgotPasswordFade,
            child: TextButton(
              onPressed: () => context.pushNamed("reset-password"),
              child: TxtWidget(
                strText:
                    AppLocalizations.of(context)!.translate("forgotPassword"),
                style: TxtStyle.rg,
              ),
            ),
          ),
          const Gap(24),
          FadeTransition(
            opacity: _buttonFade,
            child: BtnWidget(
              btnText: AppLocalizations.of(context)!.translate("signIn"),
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
