import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../components/config/app_icons.dart';
import '../../components/utils/toast_utils.dart';
import '../services/delete_shop.dart';

class ShopPageDeleteWidget extends StatefulWidget {
  final int shopId;

  const ShopPageDeleteWidget({
    super.key,
    required this.shopId,
  });

  @override
  ShopPageDeleteWidgetState createState() => ShopPageDeleteWidgetState();
}

class ShopPageDeleteWidgetState extends State<ShopPageDeleteWidget> {
  bool _isDeleting = false;

  Future<void> _handleDeleteShop(int shopId) async {
    setState(() {
      _isDeleting = true;
    });

    try {
      bool isDeleted = await deleteShop(shopId);
      if (isDeleted) {
        showToast('Shop deleted successfully!');
      } else {
        showToast('Failed to delete shop.');
      }
    } catch (e) {
      showToast('Error: $e');
    } finally {
      setState(() {
        _isDeleting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      onPressed: (value) async {
        if (_isDeleting) return;

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
          await _handleDeleteShop(widget.shopId);
        }
      },
      backgroundColor: const Color(0xFFFE4A49),
      foregroundColor: Colors.white,
      icon: AppIcons.instance.delete,
      label: _isDeleting ? 'Deleting...' : 'Delete',
    );
  }
}
