part of 'feedback_bloc.dart';

sealed class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

final class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class FeedbackSuccess extends FeedbackState {}

class FeedbackFailure extends FeedbackState {
  final String error;

  const FeedbackFailure({required this.error});

  @override
  List<Object> get props => [error];
}
