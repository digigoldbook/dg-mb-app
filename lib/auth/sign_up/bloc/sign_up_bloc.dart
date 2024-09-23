import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../services/sign_up_service.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpSubmittedEvent>((event, emit) async {
      emit(SignUpLoading());
      try {
        final body = {
          "email": event.email,
          "fullname": event.fullname,
          "password": event.password,
          "contact_no": event.contactNo,
          "meta": [
            {
              "meta_key": "role",
              "meta_value": "subscriber",
            }
          ]
        };
        final response = await signUpService(data: body);
        if (response.statusCode == 201) {
          emit(SignUpSuccess());
        } else {
          emit(const SignUpFailure(error: 'Failed to sign up'));
        }
      } catch (error) {
        emit(SignUpFailure(error: '$error'));
      }
    });
  }
}
