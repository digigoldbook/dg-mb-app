part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {
  final bool isLoading;

  const SignInLoading({
    required this.isLoading,
  });

  @override
  List<Object> get props => [isLoading];
}

final class SignInError extends SignInState {
  final String strError;

  const SignInError({
    required this.strError,
  });

  @override
  List<Object> get props => [strError];
}

final class SignInSuccess extends SignInState {}
