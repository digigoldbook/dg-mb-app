import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../components/widget/btn_widget.dart';
import '../helper/deposite_time_est.dart';

class DepositTimeEstimation extends StatefulWidget {
  const DepositTimeEstimation({super.key});

  @override
  State<DepositTimeEstimation> createState() => _DepositTimeEstimationState();
}

class _DepositTimeEstimationState extends State<DepositTimeEstimation> {
  late double goldBuyPrice = 0.0;
  late double depositePriceEstimation = 0.0;
  late double dte = 0.0;

  late int years = 0;
  late int months = 0;
  late int days = 0;

  @override
  void initState() {
    var box = Hive.box('estimationData');
    goldBuyPrice = box.get('goldBuyAmount') ?? 0.0;
    depositePriceEstimation = box.get('depositePriceEstimation') ?? 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Gold Price: Rs. $goldBuyPrice"),
        Text("Deposite Price Estimation: Rs. $depositePriceEstimation"),
        Text(
            "Deposit Time Estimation: ${years > 0 ? '$years years, ' : ''}${months > 0 ? '$months months, ' : ''}${days > 0 ? '$days days' : ''}"),
        BtnWidget(
          btnText: "Calculate Time",
          onTap: () async {
            final result = await deposteTimeEstimation(5);
            // Convert the result to years, months, and days
            setState(() {
              dte = result;
              // Assuming the result is in years as a decimal
              years = dte.floor();
              double remainingMonths = (dte - years) * 12;
              months = remainingMonths.floor();
              days = ((remainingMonths - months) * 30).round();
            });
          },
        ),
      ],
    );
  }
}
