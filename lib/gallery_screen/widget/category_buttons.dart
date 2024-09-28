import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/widget/btn_widget.dart';
import '../../components/config/app_localization.dart';

class CategoryButtons extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryButtons({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: BtnWidget(
              btnText: AppLocalizations.of(context)!.translate("all"),
              onTap: () => onCategorySelected('all'),
              isSolid: selectedCategory == 'all',
            ),
          ),
          const Gap(8),
          Expanded(
            child: BtnWidget(
              btnText: AppLocalizations.of(context)!.translate("gold"),
              onTap: () => onCategorySelected('gold'),
              isSolid: selectedCategory == 'gold',
            ),
          ),
          const Gap(8),
          Expanded(
            child: BtnWidget(
              btnText: AppLocalizations.of(context)!.translate("silver"),
              onTap: () => onCategorySelected('silver'),
              isSolid: selectedCategory == 'silver',
            ),
          ),
          const Gap(8),
          Expanded(
            child: BtnWidget(
              btnText: AppLocalizations.of(context)!.translate("diamond"),
              onTap: () => onCategorySelected('diamond'),
              isSolid: selectedCategory == 'diamond',
            ),
          ),
        ],
      ),
    );
  }
}
