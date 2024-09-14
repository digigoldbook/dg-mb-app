import 'package:flutter/material.dart';

import 'txt_widget.dart';

class BtnWidget extends StatelessWidget {
  final String btnText;
  final Function() onTap;
  final double? width;
  final bool? isSolid;
  const BtnWidget({
    super.key,
    required this.btnText,
    required this.onTap,
    this.width,
    this.isSolid = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 150,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        decoration: isSolid!
            ? BoxDecoration(
                color: const Color(0xff7695FF),
                borderRadius: BorderRadius.circular(6),
              )
            : BoxDecoration(
                border: Border.all(
                  color: const Color(0xff7695FF),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
        child: TxtWidget(
          strText: btnText,
          style: TxtStyle.rgb,
          color: isSolid! ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
