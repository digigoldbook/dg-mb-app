import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/config/app_colors.dart';
import '../../../../components/widget/btn_widget.dart';
import '../../../../components/widget/txt_widget.dart';
import '../bloc/cash_deposit_bloc.dart';

class ListItemsCashDeposit extends StatelessWidget {
  const ListItemsCashDeposit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CashDepositBloc()..add(ListCashDeposit()),
      child: BlocBuilder<CashDepositBloc, CashDepositState>(
        builder: (context, state) {
          if (state is CashDepositLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CashDepositError) {
            return Center(
              child: Text(state.strError),
            );
          } else if (state is CashDepositLoaded) {
            final cashDeposit = state.cashDepositModel;
            return ListView.builder(
              itemCount: cashDeposit.items!.length,
              itemBuilder: (context, index) {
                final item = cashDeposit.items![index];

                // Ensure null safety with default values
                int time = item.time ?? 0;
                String timeUnit = item.timeUnit ?? "month";
                double principal = double.tryParse(item.amount ?? "0") ?? 0;
                double rate = double.tryParse(item.rate ?? "0") ?? 0;

                // Convert time to days
                int timeInDays;
                if (timeUnit == "month") {
                  timeInDays = time * 30;
                } else if (timeUnit == "year") {
                  timeInDays = time * 365;
                } else {
                  timeInDays = 0;
                }

                // Calculate interest
                double interest = (principal * rate * timeInDays) / (100 * 365);
                return ListTile(
                  title: Text(item.customerName ?? 'N/A'),
                  subtitle: Text(
                    "P - ${item.amount} | T - ${item.time} (${item.timeUnit}) | R - ${item.rate}%",
                  ),
                  trailing: IconButton(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          const Center(
                            child: TxtWidget(
                              strText: "Cash Deposit Details",
                              style: TxtStyle.md,
                            ),
                          ),
                          const Gap(16),
                          TxtWidget(
                            strText:
                                "Principal: $principal \n Time: $time \n Rate: $rate",
                            style: TxtStyle.rg,
                          ),
                          const Gap(16),
                          TxtWidget(
                            strText: "Interest: ${interest.toStringAsFixed(2)}",
                            style: TxtStyle.rgb,
                          ),
                          const Gap(16),
                          BtnWidget(
                            btnText: "Delete",
                            color: AppColors.instance.redColor,
                            onTap: () {
                              context
                                  .read<CashDepositBloc>()
                                  .add(DeleteCashDepositEvent(item.id!));
                              context.pop();
                            },
                          ),
                        ],
                      ),
                    ),
                    icon: const Icon(Icons.visibility),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
