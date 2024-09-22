import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  timeInDays = 0; // Handle error or default case
                }

                // Calculate interest
                double interest = (principal * rate * timeInDays) / (100 * 365);

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Customer Name: ${item.customerName ?? 'N/A'}"),
                        Text(
                            "Customer Contact: ${item.customerContact ?? 'N/A'}"),
                        Text(
                          "P - ${item.amount} | T - ${item.time} (${item.timeUnit}) | R - ${item.rate}%",
                        ),
                        Text(
                          "Interest: Rs ${interest.toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
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
