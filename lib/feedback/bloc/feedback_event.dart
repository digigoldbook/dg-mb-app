part of 'feedback_bloc.dart';

sealed class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}

class SendFeedbackEvent extends FeedbackEvent {
  final String fullname;
  final String email;
  final String subject;
  final String message;

  const SendFeedbackEvent({
    required this.fullname,
    required this.email,
    required this.subject,
    required this.message,
  });

  @override
  List<Object> get props => [fullname, email, subject, message];
}
