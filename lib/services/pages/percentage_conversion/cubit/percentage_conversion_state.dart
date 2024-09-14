import 'package:equatable/equatable.dart';

sealed class PercentageConversionState extends Equatable {
  final String inputText;
  final String outputText;

  const PercentageConversionState({this.inputText = '', this.outputText = ''});

  @override
  List<Object> get props => [inputText, outputText];
}

final class PercentageInitial extends PercentageConversionState {}

final class PercentageUpdated extends PercentageConversionState {
  const PercentageUpdated(
      {required super.inputText, required super.outputText});
}

final class PercentageError extends PercentageConversionState {
  final String message;

  const PercentageError(this.message);

  @override
  List<Object> get props => [message];
}
