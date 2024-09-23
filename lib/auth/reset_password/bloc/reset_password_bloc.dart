import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../services/reset_password_service.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<ResetPasswordSubmitted>((event, emit) async {
      emit(ResetPasswordLoading());
      try {
        final Map<String, dynamic> body = {
          'newPassword': event.password,
          'confirmPassword': event.confirmPassword,
        };
        final response = await resetPasswordService(
          params: {
            'email': event.email,
          },
          data: body,
        );
        if (response.statusCode == 200) {
          emit(ResetPasswordSuccess());
        } else {
          emit(const ResetPasswordFailure(error: 'Failed to reset password'));
        }
      } catch (error) {
        emit(ResetPasswordFailure(error: '$error'));
      }
    });
  }
}
