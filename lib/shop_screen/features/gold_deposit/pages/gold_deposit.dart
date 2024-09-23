import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../components/widget/app_bar.dart';
import '../widgets/gold_item_display.dart';

class GoldDeposit extends StatefulWidget {
  const GoldDeposit({super.key});

  @override
  State<GoldDeposit> createState() => _GoldDepositState();
}

class _GoldDepositState extends State<GoldDeposit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: const GoldItemsDisplay(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed("add-gold-deposit-record"),
        label: const Text("Record"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
