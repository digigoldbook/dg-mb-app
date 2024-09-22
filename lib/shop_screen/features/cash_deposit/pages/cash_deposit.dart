import 'package:flutter/material.dart';
import '../../../../components/widget/app_bar.dart';
import '../widgets/cash_deposit_fab.dart';
import '../widgets/list_items_cash_deposit.dart';

class CashDeposit extends StatelessWidget {
  const CashDeposit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: const ListItemsCashDeposit(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
          context: (context),
          builder: (context) => const CashDepositFab(),
        ),
        label: const Text("New Deposit"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
