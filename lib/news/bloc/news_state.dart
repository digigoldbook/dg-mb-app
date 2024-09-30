part of 'news_bloc.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {}

final class NewsLoading extends NewsState {}

final class NewsSuccess extends NewsState {
  final dynamic data;

  const NewsSuccess({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}

final class NewsError extends NewsState {
  final String error;

  const NewsError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
