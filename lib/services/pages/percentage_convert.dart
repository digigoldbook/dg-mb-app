import 'package:flutter/material.dart';
import '../../components/utils/toast_utils.dart';
import '../calculator/calculator_button_row.dart';
import '../calculator/calculator_display.dart';

class PercentageConvert extends StatefulWidget {
  const PercentageConvert({super.key});

  @override
  State<PercentageConvert> createState() => _PercentageConvertState();
}

class _PercentageConvertState extends State<PercentageConvert> {
  String _inputText = '';
  String _outputText = '';
  bool _isCaretToPercentage = true; // To track conversion mode

  // Function to handle button clicks
  void _onButtonClick(String value) {
    setState(() {
      if (value == 'C') {
        // Clear the last character in the input
        if (_inputText.isNotEmpty) {
          _inputText = _inputText.substring(0, _inputText.length - 1);
        }
      } else if (value == '=') {
        _calculate();
      } else {
        _inputText += value;
      }
    });
  }

  // Method to calculate based on the current mode
  void _calculate() {
    if (_inputText.isNotEmpty) {
      final inputValue = double.tryParse(_inputText);
      if (inputValue != null) {
        if (_isCaretToPercentage) {
          // Caret to Percentage Calculation
          if (inputValue > 24) {
            showToast(
                "Value exceeds 24. Not accepted!"); // Use the toast utility
            _outputText = ''; // Clear output if the input exceeds 24
          } else {
            final percentage = (inputValue / 24) * 100;
            _outputText = "${percentage.toStringAsFixed(2)}%";
          }
        } else {
          // Percentage to Caret Calculation
          if (inputValue > 100) {
            showToast(
                "Percentage exceeds 100%. Not accepted!"); // Use the toast utility
            _outputText = ''; // Clear output if the input exceeds 100%
          } else {
            final caretValue = (inputValue / 100) * 24;
            _outputText = "${caretValue.toStringAsFixed(2)} caret";
          }
        }
      } else {
        showToast(
            "Invalid input. Please enter a valid number."); // Use the toast utility
      }
    }
  }

  // Method to toggle between caret to percentage and percentage to caret
  void _toggleConversionMode() {
    setState(() {
      _isCaretToPercentage = !_isCaretToPercentage;
      _inputText = '';
      _outputText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCaretToPercentage
            ? "Caret to Percentage Calculator"
            : "Percentage to Caret Calculator"),
      ),
      body: Column(
        children: [
          // Display Area
          Expanded(
            flex: 1,
            child: CalculatorDisplay(
              inputText: _inputText +
                  (_isCaretToPercentage
                      ? ' caret'
                      : ' %'), // Display symbol based on mode
              outputText: _outputText,
            ),
          ),
          // Keypad Area
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ButtonRow(
                    buttonLabels: const ['7', '8', '9'],
                    onButtonPressed: _onButtonClick,
                  ),
                  ButtonRow(
                    buttonLabels: const ['4', '5', '6'],
                    onButtonPressed: _onButtonClick,
                  ),
                  ButtonRow(
                    buttonLabels: const ['1', '2', '3'],
                    onButtonPressed: _onButtonClick,
                  ),
                  ButtonRow(
                    buttonLabels: const ['0', '.', 'C'],
                    onButtonPressed: _onButtonClick,
                  ),
                  ButtonRow(
                    buttonLabels: const ['='],
                    onButtonPressed: _onButtonClick,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleConversionMode,
        tooltip: 'Toggle Conversion Mode',
        child: const Icon(Icons.swap_horiz), // Icon to indicate switching modes
      ),
    );
  }
}
