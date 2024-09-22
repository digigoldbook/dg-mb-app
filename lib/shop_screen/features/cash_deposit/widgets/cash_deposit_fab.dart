import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/widget/btn_widget.dart';
import 'package:flutter_application_1/components/widget/txt_widget.dart';
import 'package:gap/gap.dart';
import 'package:dio/dio.dart';

import '../../../../components/widget/text_field_widget.dart';

class CashDepositFab extends StatefulWidget {
  const CashDepositFab({super.key});

  @override
  State<CashDepositFab> createState() => _CashDepositFabState();
}

class _CashDepositFabState extends State<CashDepositFab> {
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _rate = TextEditingController();
  final TextEditingController _time = TextEditingController();

  double? _interest;
  bool _isInterestCalculated = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Center(
          child: TxtWidget(
            strText: "Add Cash Deposit",
            style: TxtStyle.rgb,
          ),
        ),
        const Gap(16),
        TextFieldWidget(
          controller: _amount,
          inputType: TextInputType.number,
          hintText: "Enter amount",
          prefixIcon: Icons.numbers,
        ),
        const Gap(16),
        TextFieldWidget(
          controller: _rate,
          inputType: TextInputType.number,
          hintText: "Enter rate",
          prefixIcon: Icons.percent,
        ),
        const Gap(16),
        TextFieldWidget(
          controller: _time,
          inputType: TextInputType.number,
          hintText: "Enter time (in months)",
          prefixIcon: Icons.watch,
        ),
        const Gap(32),
        BtnWidget(
          btnText: "Calculate Interest",
          onTap: () {
            setState(() {
              _calculateInterest();
            });
          },
        ),
        const Gap(16),
        if (_interest != null)
          Center(
            child: TxtWidget(
              strText:
                  "Calculated Interest: \$${_interest!.toStringAsFixed(2)}",
              style: TxtStyle.rgb,
            ),
          ),
        const Gap(16),
        if (_isInterestCalculated)
          BtnWidget(
            btnText: "Add to Book",
            onTap: _addToBook,
          ),
      ],
    );
  }

  void _calculateInterest() {
    // Parse the input values from the text fields
    double? amount = double.tryParse(_amount.text);
    double? rate = double.tryParse(_rate.text);
    int? time = int.tryParse(_time.text); // Time is in months

    // Ensure all values are provided and valid
    if (amount != null && rate != null && time != null) {
      // Convert time from months to days (assuming 30 days per month)
      int timeInDays = time * 30;

      // Calculate interest using formula (P * R * T) / (100 * 365)
      _interest = (amount * rate * timeInDays) / (100 * 365);
      _isInterestCalculated = true;
    } else {
      // Handle invalid input
      _interest = null;
      _isInterestCalculated = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please enter valid values for amount, rate, and time.')),
      );
    }
  }

  Future<void> _addToBook() async {
    double? amount = double.tryParse(_amount.text);
    double? rate = double.tryParse(_rate.text);
    int? time = int.tryParse(_time.text);

    if (amount != null && rate != null && time != null && _interest != null) {
      // Create a Dio instance
      Dio dio = Dio();

      // Prepare the data to send in the POST request
      Map<String, dynamic> cashDepositData = {
        "amount": amount,
        "rate": rate,
        "time": time,
        "interest": _interest,
      };

      try {
        // Send the POST request
        Response response = await dio.post(
          'http://localhost:3000/api/cash-deposit/',
          data: cashDepositData,
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully added to the book!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add. Try again!')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}
