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

  // Function to handle button clicks
  void _onButtonClick(String value) {
    setState(() {
      if (value == 'C') {
        // Clear the last character in the input
        if (_inputText.isNotEmpty) {
          _inputText = _inputText.substring(0, _inputText.length - 1);
        }
      } else if (value == '=') {
        _calculatePercentage();
      } else {
        _inputText += value;
      }
    });
  }

  // Method to calculate percentage based on 24 as 100%
  void _calculatePercentage() {
    if (_inputText.isNotEmpty) {
      final inputValue = double.tryParse(_inputText);
      if (inputValue != null) {
        if (inputValue > 24) {
          showToast("Value exceeds 24. Not accepted!"); // Use the toast utility
          _outputText = ''; // Clear output if the input exceeds 24
        } else {
          final percentage = (inputValue / 24) * 100;
          _outputText = "${percentage.toStringAsFixed(2)}%";
        }
      } else {
        showToast(
            "Invalid input. Please enter a valid number."); // Use the toast utility
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Percentage Calculator"),
      ),
      body: Column(
        children: [
          // Display Area
          Expanded(
            flex: 1,
            child: CalculatorDisplay(
              inputText: _inputText,
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
    );
  }
}
