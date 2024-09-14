import 'package:flutter_bloc/flutter_bloc.dart';

import 'percentage_conversion_state.dart';

class PercentageConversionCubit extends Cubit<PercentageConversionState> {
  PercentageConversionCubit() : super(PercentageInitial());

  void updateInput(String value) {
    if (value == 'C') {
      final newInputText = state.inputText.isNotEmpty
          ? state.inputText.substring(0, state.inputText.length - 1)
          : '';
      emit(PercentageUpdated(
          inputText: newInputText, outputText: state.outputText));
    } else {
      // Handle number input
      final newInputText = state.inputText + value;
      emit(PercentageUpdated(
          inputText: newInputText, outputText: state.outputText));
    }
  }

  void calculatePercentage() {
    final inputValue = double.tryParse(state.inputText);
    if (inputValue != null && inputValue <= 24) {
      final percentage = (inputValue / 24) * 100;
      emit(PercentageUpdated(
        inputText: state.inputText,
        outputText: "${percentage.toStringAsFixed(2)}%",
      ));
    } else {
      emit(const PercentageError(
          "Invalid input. Please enter a number up to 24."));
    }
  }
}
