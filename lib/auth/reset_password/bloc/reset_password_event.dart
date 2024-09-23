part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetPasswordSubmitted extends ResetPasswordEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const ResetPasswordSubmitted({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
