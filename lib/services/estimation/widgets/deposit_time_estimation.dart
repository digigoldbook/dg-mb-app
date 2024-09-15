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

  @override
  void initState() {
    var box = Hive.box('estimationData');
    goldBuyPrice = box.get('goldBuyAmount');
    depositePriceEstimation = box.get('depositePriceEstimation');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Gold Price: $goldBuyPrice"),
        Text("Deposite Price Estimation Price: $depositePriceEstimation"),
        Text("Deposite Price Estimation Price: $depositePriceEstimation"),
        BtnWidget(
          btnText: "Calculate Time",
          onTap: () {
            deposteTimeEstimation(5);
          },
        ),
      ],
    );
  }
}
