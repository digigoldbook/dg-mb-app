import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ShopPageUpdateWidget extends StatelessWidget {
  final int shopId;
  const ShopPageUpdateWidget({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      onPressed: (value) {},
      backgroundColor: const Color.fromARGB(255, 73, 88, 254),
      foregroundColor: Colors.white,
      icon: Icons.update,
      label: 'Update',
    );
  }
}
