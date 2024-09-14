import 'package:flutter/material.dart';

import '../../components/widget/txt_widget.dart';

class GalleryChipWidget extends StatelessWidget {
  final String label;
  final Widget avatar;
  final Function() onPressed;
  const GalleryChipWidget({
    super.key,
    required this.label,
    required this.avatar,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: avatar,
      label: TxtWidget(strText: label, style: TxtStyle.rgb),
      onPressed: onPressed,
    );
  }
}
