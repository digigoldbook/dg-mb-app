import 'package:flutter/material.dart';

import '../calculator/calculator_button_row.dart';
import '../calculator/calculator_display.dart';
import '../helper/conversion.dart';
import '../utils/conversion_factors.dart';

class UnitConverter extends StatefulWidget {
  const UnitConverter({super.key});

  @override
  UnitConverterState createState() => UnitConverterState();
}

class UnitConverterState extends State<UnitConverter> {
  final List<String> units = unitToGrams.keys.toList();
  String fromUnit = 'gm';
  double inputValue = 0.0;
  String _inputText = '';
  String _outputText = '';
  Map<String, double> convertedValues = {};

  void convert() {
    setState(() {
      convertedValues.clear();
      for (String unit in units) {
        if (unit != fromUnit) {
          convertedValues[unit] = convertUnit(inputValue, fromUnit, unit);
        }
      }
    });

    _showConversionResult(context);
  }

  void _selectUnit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: units.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(units[index]),
              onTap: () {
                setState(() {
                  fromUnit = units[index];
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  void _showConversionResult(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: convertedValues.entries.map((entry) {
              return ListTile(
                title: Text(
                  '${entry.key}: ${entry.value.toStringAsFixed(4)}',
                  style: const TextStyle(fontSize: 20),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _inputText = '';
        inputValue = 0.0;
        _outputText = ''; // Reset _outputText to empty
        convertedValues.clear();
      } else if (value == '=') {
        inputValue = double.tryParse(_inputText) ?? 0.0;
        convert();
      } else {
        _inputText += value;
        _outputText = ''; // Reset _outputText when a new input is entered
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(fromUnit),
                      IconButton(
                        onPressed: () => _selectUnit(context),
                        icon: const Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),
                ),
                CalculatorDisplay(
                  inputText: _inputText,
                  outputText: _outputText,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ButtonRow(
                    buttonLabels: const ['7', '8', '9'],
                    onButtonPressed: _onButtonPressed,
                  ),
                  ButtonRow(
                    buttonLabels: const ['4', '5', '6'],
                    onButtonPressed: _onButtonPressed,
                  ),
                  ButtonRow(
                    buttonLabels: const ['1', '2', '3'],
                    onButtonPressed: _onButtonPressed,
                  ),
                  ButtonRow(
                    buttonLabels: const ['0', '.', 'C'],
                    onButtonPressed: _onButtonPressed,
                  ),
                  ButtonRow(
                    buttonLabels: const ['='],
                    onButtonPressed: _onButtonPressed,
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
