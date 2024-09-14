import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../components/utils/toast_utils.dart';

class ShopPageDeleteWidget extends StatelessWidget {
  final int shopId;
  const ShopPageDeleteWidget({super.key, required this.shopId});

  Future<void> _deleteShop(int shopId) async {
    try {
      Dio dio = Dio();
      final String url = 'http://localhost:3000/api/v1/shops?shopId=$shopId';

      final response = await dio.delete(url);

      if (response.statusCode == 200) {
        showToast('Shop deleted successfully!');
      } else {
        showToast('Failed to delete shop.');
      }
    } catch (e) {
      showToast('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      onPressed: (value) async {
        // Confirm delete action
        bool? confirmDelete = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Delete'),
              content: const Text('Are you sure you want to delete this shop?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );

        if (confirmDelete == true) {
          await _deleteShop(shopId);
        }
      },
      backgroundColor: const Color(0xFFFE4A49),
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: 'Delete',
    );
  }
}
