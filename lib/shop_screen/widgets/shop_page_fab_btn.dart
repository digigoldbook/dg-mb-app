import 'package:flutter/material.dart';

import '../../components/config/app_icons.dart';
import '../pages/add_shop_page.dart';

class ShopPageFabBtn extends StatefulWidget {
  const ShopPageFabBtn({super.key});

  @override
  State<ShopPageFabBtn> createState() => _ShopPageFabBtnState();
}

class _ShopPageFabBtnState extends State<ShopPageFabBtn> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Allows better control over the sheet size
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.55, // Initial height 40%
          minChildSize: 0.4, // Minimum height 40%
          maxChildSize: 0.7, // Max height 60% (to avoid full screen)
          expand: false, // Allow it to be draggable without full expansion
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: const AddShopPage(),
            );
          },
        ),
      ),
      icon: Icon(AppIcons.instance.shop),
      label: const Text("Register Shop"),
    );
  }
}
