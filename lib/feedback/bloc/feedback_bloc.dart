import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../services/feed_back_service.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackInitial()) {
    FeedBackService feedBackService = FeedBackService();
    on<SendFeedbackEvent>((event, emit) async {
      emit(FeedbackLoading());
      try {
        final body = {
          'fullname': event.fullname,
          'email': event.email,
          'subject': event.subject,
          'message': event.message,
        };
        final response = await feedBackService.sendFeedback(
          data: body,
        );
        if (response.statusCode == 201) {
          emit(FeedbackSuccess());
        } else {
          emit(const FeedbackFailure(error: 'Failed to send feedback'));
        }
      } catch (e) {
        emit(FeedbackFailure(error: '$e'));
      }
    });
  }
}
