import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../components/config/app_localization.dart';
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
  final TextEditingController _todayGoldPrice =
      TextEditingController(text: "152000");
  final TextEditingController _goldWeight = TextEditingController();
  final TextEditingController _unit = TextEditingController();
  final TextEditingController _buyRate = TextEditingController();

  double? _calculatedPrice; // To store the calculated buying price

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWidget(
          controller: _todayGoldPrice,
          inputType: TextInputType.number,
          hintText: "Gold Rate: ",
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
                hintText: AppLocalizations.of(context)!.translate("weight"),
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
          hintText: AppLocalizations.of(context)!.translate("rate"),
          prefixIcon: Icons.percent,
        ),
        const Gap(32),
        BtnWidget(
          btnText: "Buying Price",
          onTap: () async {
            // Ensure inputs are valid and not empty
            if (_todayGoldPrice.text.isNotEmpty &&
                _goldWeight.text.isNotEmpty &&
                _buyRate.text.isNotEmpty) {
              // Calculate the price
              double result = await calculateBuyingPrice(
                double.parse(_todayGoldPrice.text),
                double.parse(_goldWeight.text),
                double.parse(_buyRate.text),
              );

              // Update state to display result
              setState(() {
                _calculatedPrice = result;
              });

              // Update Estimation Step Cubit
              // ignore: use_build_context_synchronously
              context.read<EstimationStepCubit>().updateStep(1);
            } else {
              // Handle validation errors here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please fill all fields")),
              );
            }
          },
        ),
        const Gap(16),
        // Display the result of the calculation
        if (_calculatedPrice != null)
          Text(
            'Calculated Buying Price: Rs. $_calculatedPrice',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
