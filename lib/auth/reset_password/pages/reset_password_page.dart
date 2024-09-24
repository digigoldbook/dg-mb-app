import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../components/config/app_icons.dart';
import '../../../components/utils/toast_utils.dart';
import '../../../components/widget/app_bar.dart';
import '../../../components/widget/btn_widget.dart';
import '../../../components/widget/text_field_widget.dart';
import '../bloc/reset_password_bloc.dart';
import '../services/reset_password_service.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final PageController _pageController = PageController();
  bool _isHidden = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: "Reset Password",
      ),
      body: BlocListener<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordLoading) {
            showToast("Resetting Password");
          } else if (state is ResetPasswordSuccess) {
            showToast("Password reset successful");
            // Optionally navigate to the login page
          } else if (state is ResetPasswordFailure) {
            showToast(state.error);
          }
        },
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildEmailInputPage(),
            _buildPasswordResetPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailInputPage() {
    return Center(
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
          BtnWidget(
            btnText: "Next",
            onTap: () async {
              if (_email.text.isNotEmpty) {
                bool exists =
                    await ResetPasswordService().checkUserExistince(params: {
                  "email": _email.text,
                });
                if (exists) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                } else {
                  showToast("User does not exist!");
                }
              } else {
                showToast("Please enter a valid email!");
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordResetPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                    ? AppIcons.instance.visibilityoff
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
          const Gap(32),
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
                showToast("Passwords do not match!");
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
