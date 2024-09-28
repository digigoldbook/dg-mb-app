import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/widget/btn_widget.dart';
import '../model/jewelry_model.dart';

class GalleryBottomSheet extends StatelessWidget {
  final List<JewelryItem> currentItems;
  final VoidCallback onCancel;
  final VoidCallback onFilter;

  const GalleryBottomSheet({
    super.key,
    required this.currentItems,
    required this.onCancel,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 500, // Set the desired height
      child: Column(
        children: [
          const Text(
            'Jewelry Items',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView(
              children: currentItems.map((item) {
                return ListTile(
                  title: Text(item.name),
                  onTap: () {
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
          const Divider(),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BtnWidget(
                onTap: onCancel,
                btnText: "Cancel",
                isSolid: false,
              ),
              BtnWidget(
                onTap: onFilter,
                btnText: "Filter",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
