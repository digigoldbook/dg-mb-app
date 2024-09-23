import 'package:flutter/material.dart';

import '../../components/widget/app_bar.dart';
import '../widgets/shop_page_fab_btn.dart';
import 'shop_ui_page.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: const ShopUiPage(),
      floatingActionButton: const ShopPageFabBtn(),
    );
  }
}
