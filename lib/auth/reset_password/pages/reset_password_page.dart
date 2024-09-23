import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../components/config/app_icons.dart';
import '../../../components/utils/toast_utils.dart';
import '../../../components/widget/app_bar.dart';
import '../../../components/widget/btn_widget.dart';
import '../../../components/widget/text_field_widget.dart';
import '../bloc/reset_password_bloc.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Reset Password"),
      body: BlocListener<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordLoading) {
            showToast("Reseting Password");
          } else if (state is ResetPasswordSuccess) {
            showToast("Password reset successful");
          } else if (state is ResetPasswordFailure) {
            showToast(state.error);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldWidget(
              controller: _email,
              inputType: TextInputType.emailAddress,
              hintText: "Enter valid email",
              prefixIcon: AppIcons.instance.email,
            ),
            const Gap(16),
            TextFieldWidget(
              isObscureText: _isHidden,
              controller: _password,
              inputType: TextInputType.visiblePassword,
              hintText: "New Password",
              prefixIcon: AppIcons.instance.security,
              suffix: IconButton(
                onPressed: () => setState(() {
                  _isHidden = !_isHidden;
                }),
                icon: Icon(
                  _isHidden
                      ? AppIcons.instance.visibility_off
                      : AppIcons.instance.visibility,
                ),
              ),
            ),
            const Gap(16),
            TextFieldWidget(
              controller: _confirmPassword,
              inputType: TextInputType.visiblePassword,
              hintText: "Confirm Password",
              prefixIcon: AppIcons.instance.security,
            ),
            const Gap(8 * 4),
            BtnWidget(
              btnText: "Reset Password",
              onTap: () {
                if (_password.text == _confirmPassword.text) {
                  context.read<ResetPasswordBloc>().add(
                        ResetPasswordSubmitted(
                          email: _email.text,
                          password: _password.text,
                          confirmPassword: _confirmPassword.text,
                        ),
                      );
                } else {
                  showToast("Password do not match!");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }
}
