import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/list_gold_deposit_bloc.dart';

class GoldItemsDisplay extends StatelessWidget {
  const GoldItemsDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListGoldDepositBloc()..add(FetchGoldDeposit()),
      child: BlocBuilder<ListGoldDepositBloc, ListGoldDepositState>(
        builder: (context, state) {
          if (state is GoldDepostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GoldDepostLoaded) {
            final goldDeposit = state.goldDeposit;
            return ListView.builder(
              itemCount: goldDeposit.data!.length,
              itemBuilder: (context, index) {
                final post = goldDeposit.data![index];
                final createdAt = DateTime.parse(
                    post.createdAt.toString()); // Parse createdAt string

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Text(
                      "Post Title: ${post.postTitle}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      "Updated Date: ${post.updatedAt}",
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 14),
                    ),
                    children: [
                      // Nested expandable list of items
                      ...post.items!.map((item) => ExpansionTile(
                            title: Text("Product: ${item.productTitle}"),
                            children: [
                              ListTile(
                                title: Text("Amount: ${item.productAmt}"),
                              ),
                              ListTile(
                                title: Text(
                                    "Period: ${item.period} ${item.periodUnit}"),
                              ),
                              ListTile(
                                title: Text("Rate: ${item.rate}%"),
                              ),
                              ListTile(
                                title: Text(
                                  "Interest: ₹${_calculateInterest(item, createdAt)}", // Display calculated interest
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                );
              },
            );
          } else if (state is GoldDepostError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No data found.'));
          }
        },
      ),
    );
  }

  // Method to calculate interest based on product details and time since creation
  String _calculateInterest(item, DateTime createdAt) {
    final amount = item.productAmt ?? 0.0;
    final rate = item.rate ?? 0.0;

    // Calculate the number of days since creation
    final daysSinceCreation = _calculateDaysSinceCreation(createdAt);

    // Convert days to years for interest calculation
    final timeInYears = daysSinceCreation / 365.0;

    // Calculate the interest
    final interest = (amount * timeInYears * rate) / 100.0;

    return interest.toStringAsFixed(2);
  }

  // Helper method to calculate days since creation date
  int _calculateDaysSinceCreation(DateTime createdAt) {
    final now = DateTime.now();
    return now.difference(createdAt).inDays;
  }
}
