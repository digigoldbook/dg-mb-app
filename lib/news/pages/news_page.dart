import 'package:flutter/material.dart';

import '../../components/config/app_localization.dart';
import '../../components/widget/app_bar.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: AppLocalizations.of(context)!.translate("news"),
      ),
    );
  }
}
