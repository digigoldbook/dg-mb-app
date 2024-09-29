import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../components/widget/btn_widget.dart';
import '../../../components/widget/text_field_widget.dart';
import '../cubit/estimation_step_cubit.dart';
import '../helper/deposite_price.dart';

class DepositePriceEstimation extends StatefulWidget {
  const DepositePriceEstimation({super.key});

  @override
  State<DepositePriceEstimation> createState() =>
      _DepositePriceEstimationState();
}

class _DepositePriceEstimationState extends State<DepositePriceEstimation> {
  final TextEditingController _goldWeight = TextEditingController();
  final TextEditingController _buyGoldPrice = TextEditingController();
  final TextEditingController _unit = TextEditingController();
  final TextEditingController _insuranceRate = TextEditingController();

  void _loadLocaData() async {
    var box = await Hive.openBox('estimationData');
    _buyGoldPrice.text = box.get('goldBuyAmount', defaultValue: '0').toString();
    _goldWeight.text = box.get('productWeight', defaultValue: '0').toString();
  }

  @override
  void initState() {
    _loadLocaData();
    super.initState();
  }

  @override
  void dispose() {
    _goldWeight.clear();
    _buyGoldPrice.clear();
    _unit.clear();
    _insuranceRate.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWidget(
          controller: _buyGoldPrice,
          inputType: TextInputType.number,
          hintText: "Rs. 1,52,000",
          prefixIcon: Icons.payment,
          readOnly: true,
        ),
        const Gap(16),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFieldWidget(
                controller: _goldWeight,
                inputType: TextInputType.number,
                hintText: "Product Weight",
                prefixIcon: Icons.payment,
              ),
            ),
            const Gap(16),
            Expanded(
              child: TextFieldWidget(
                controller: _unit,
                inputType: TextInputType.number,
                readOnly: true,
                hintText: "gm",
                prefixIcon: Icons.scale,
              ),
            ),
          ],
        ),
        const Gap(16),
        TextFieldWidget(
          controller: _insuranceRate,
          inputType: TextInputType.number,
          hintText: "Insurance Rate",
          prefixIcon: Icons.percent,
        ),
        const Gap(8 * 4),
        BtnWidget(
          btnText: "Buying Price",
          onTap: () {
            depostePrice(
              double.parse(_buyGoldPrice.text),
              double.parse(_goldWeight.text),
              double.parse(_insuranceRate.text),
            );
            context.read<EstimationStepCubit>().updateStep(2);
          },
        ),
      ],
    );
  }
}
