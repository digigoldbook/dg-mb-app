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
            if (state.goldDeposit.pagination!.totalCount == 0) {
              return const Center(
                child: Text("Nothing to Display"),
              );
            } else {
              final goldDeposit = state.goldDeposit;
              return ListView.builder(
                itemCount: goldDeposit.data!.length,
                itemBuilder: (context, index) {
                  final post = goldDeposit.data![index];

                  // Create a list of items under the product
                  final productTitles = post.productTitle!.map((title) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        "- ${title.item}",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList();

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionTile(
                      title: Text(
                        "Product: ${post.productName}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        "Updated Date: ${post.updatedAt}",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 14),
                      ),
                      // Children are displayed when the ExpansionTile is expanded
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: productTitles, // Display product titles
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            "Product Amount: ${post.productAmount}",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            "asdasd",
                            // "Interest: ${_calculateInterest(post, DateTime.parse(post.createdAt))}",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
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
    final amount = double.tryParse(item.productAmount ?? '0') ?? 0.0;
    final rate = double.tryParse(item.productRate ?? '0') ?? 0.0;

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
