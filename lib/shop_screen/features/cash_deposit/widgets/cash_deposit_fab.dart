import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/config/app_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../bloc/cash_deposit_bloc.dart';
import '../../../../components/utils/toast_utils.dart';
import '../../../../components/widget/btn_widget.dart';
import '../../../../components/widget/text_field_widget.dart';
import '../../../../components/widget/txt_widget.dart';

class CashDepositFab extends StatefulWidget {
  const CashDepositFab({super.key});

  @override
  State<CashDepositFab> createState() => _CashDepositFabState();
}

class _CashDepositFabState extends State<CashDepositFab> {
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _rate = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _customerName = TextEditingController();
  final TextEditingController _customerContact = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CashDepositBloc(),
      child: BlocConsumer<CashDepositBloc, CashDepositState>(
        listener: (context, state) {
          if (state is CashDepositSuccess) {
            showToast("Successfully added to the book!");
          } else if (state is CashDepositFailure) {
            showToast(state.error);
          }
        },
        builder: (context, state) {
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
                hintText: AppLocalizations.of(context)!.translate("amount"),
                prefixIcon: Icons.numbers,
              ),
              const Gap(16),
              TextFieldWidget(
                controller: _rate,
                inputType: TextInputType.number,
                hintText: AppLocalizations.of(context)!.translate("rate"),
                prefixIcon: Icons.percent,
              ),
              const Gap(16),
              TextFieldWidget(
                controller: _time,
                inputType: TextInputType.number,
                hintText: AppLocalizations.of(context)!.translate("period"),
                prefixIcon: Icons.watch,
              ),
              const Gap(16),
              TextFieldWidget(
                controller: _customerName,
                inputType: TextInputType.text,
                hintText:
                    AppLocalizations.of(context)!.translate("customerName"),
                prefixIcon: Icons.person,
              ),
              const Gap(16),
              TextFieldWidget(
                controller: _customerContact,
                inputType: TextInputType.text,
                hintText: AppLocalizations.of(context)!.translate("contactNo"),
                prefixIcon: Icons.phone,
              ),
              const Gap(32),
              BtnWidget(
                btnText: "Calculate Interest",
                onTap: () {
                  double? amount = double.tryParse(_amount.text);
                  double? rate = double.tryParse(_rate.text);
                  int? time = int.tryParse(_time.text);

                  if (amount != null && rate != null && time != null) {
                    context
                        .read<CashDepositBloc>()
                        .add(CalculateInterestEvent(amount, rate, time));
                  } else {
                    showToast("Please enter valid values.");
                  }
                },
              ),
              const Gap(16),
              if (state is InterestCalculated)
                Center(
                  child: TxtWidget(
                    strText:
                        "Calculated Interest: Rs. ${state.interest.toStringAsFixed(2)}",
                    style: TxtStyle.rgb,
                  ),
                ),
              const Gap(16),
              if (state is InterestCalculated)
                BtnWidget(
                  btnText: "Add to Book",
                  onTap: () {
                    double? amount = double.tryParse(_amount.text);
                    double? rate = double.tryParse(_rate.text);
                    int? time = int.tryParse(_time.text);

                    if (amount != null && rate != null && time != null) {
                      context.read<CashDepositBloc>().add(AddToBookEvent(
                            amount,
                            rate,
                            time,
                            state.interest,
                            _customerName.text,
                            _customerContact.text,
                          ));
                    }
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
