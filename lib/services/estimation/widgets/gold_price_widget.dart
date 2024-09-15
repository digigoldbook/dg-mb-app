import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../components/widget/btn_widget.dart';
import '../../../components/widget/text_field_widget.dart';
import '../cubit/estimation_step_cubit.dart';
import '../helper/calculate_buying_price.dart';

class GoldPriceWidget extends StatefulWidget {
  const GoldPriceWidget({super.key});

  @override
  State<GoldPriceWidget> createState() => _GoldPriceWidgetState();
}

class _GoldPriceWidgetState extends State<GoldPriceWidget> {
  final TextEditingController _todayGoldPrice = TextEditingController();
  final TextEditingController _goldWeight = TextEditingController();
  final TextEditingController _unit = TextEditingController();
  final TextEditingController _buyRate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWidget(
          controller: _todayGoldPrice,
          inputType: TextInputType.number,
          hintText: "Rs. 1,52,000",
          prefixIcon: Icons.payment,
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
          controller: _buyRate,
          inputType: TextInputType.number,
          hintText: "5%",
          prefixIcon: Icons.percent,
        ),
        const Gap(8 * 4),
        BtnWidget(
          btnText: "Buying Price",
          onTap: () {
            calculateBuyingPrice(
              double.parse(_todayGoldPrice.text),
              double.parse(_goldWeight.text),
              double.parse(_buyRate.text),
            );
            context.read<EstimationStepCubit>().updateStep(1);
          },
        ),
      ],
    );
  }
}
