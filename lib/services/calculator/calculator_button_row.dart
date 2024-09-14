import 'package:flutter/material.dart';
import 'calculator_button.dart';

class ButtonRow extends StatelessWidget {
  final List<String> buttonLabels;
  final void Function(String) onButtonPressed;

  const ButtonRow({
    super.key,
    required this.buttonLabels,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttonLabels.map((label) {
          Color color;
          if (label == 'C') {
            color = const Color(0xFFC7253E);
          } else if (label == '=') {
            color = const Color(0xff6A9C89);
          } else {
            color = Colors.blueGrey[800]!;
          }
          return CalculatorButton(
            label: label,
            onPressed: () => onButtonPressed(label),
            color: color,
          );
        }).toList(),
      ),
    );
  }
}
