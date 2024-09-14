import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../hive/token_storage.dart';
import '../services/sign_in_service.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    final SignInService signInService = SignInService();
    on<SignInSubmitForm>((event, emit) async {
      final String email = event.email;
      final String password = event.password;
      List<String> error = [];

      if (email.isEmpty) {
        error.add("Email is required");
      }
      if (password.isEmpty) {
        error.add("Password is required");
      }

      if (password.length < 6) {
        error.add("Password should be more than 6 length");
      }
      if (error.isNotEmpty) {
        emit(SignInError(strError: error.join('\n')));
        return;
      }
      emit(const SignInLoading(isLoading: true));
      try {
        final signInResponse = await signInService.signInUser(email, password);
        if (signInResponse != null) {
          await TokenStorage.saveTokens(
            signInResponse.accessToken,
            signInResponse.refreshToken,
          );
          emit(SignInSuccess());
        } else {
          emit(const SignInError(strError: "Invalid email or password."));
        }
      } catch (error) {
        emit(SignInError(strError: "$error"));
      }
    });
  }
}
