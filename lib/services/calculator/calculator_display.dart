// calculator_display.dart
import 'package:flutter/material.dart';

class CalculatorDisplay extends StatelessWidget {
  final String inputText;
  final String outputText;

  const CalculatorDisplay({
    super.key,
    required this.inputText,
    required this.outputText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.bottomRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            inputText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            outputText,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
