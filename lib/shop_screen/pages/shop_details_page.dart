import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/widget/app_bar.dart';

class ShopDetailsPage extends StatelessWidget {
  const ShopDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              onTap: () {},
              title: const Text("Kaligar Deposit"),
            ),
            ListTile(
              onTap: () => context.pushNamed("gold-deposit"),
              title: const Text("Gold Deposit"),
            ),
            ListTile(
              onTap: () => context.pushNamed("cash-deposit"),
              title: const Text("Cash Deposit"),
            ),
          ],
        ),
      ),
    );
  }
}
