import 'package:flutter/material.dart';

import '../../components/config/app_icons.dart';
import '../../components/config/app_localization.dart';
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
        isScrollControlled: true,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.55,
          minChildSize: 0.4,
          maxChildSize: 0.7,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: const AddShopPage(),
            );
          },
        ),
      ),
      icon: Icon(AppIcons.instance.shop),
      label: Text(AppLocalizations.of(context)!.translate("registerShop")),
    );
  }
}
