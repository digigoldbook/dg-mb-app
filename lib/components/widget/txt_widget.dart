import 'package:flutter/material.dart';

enum TxtStyle { xs, sm, rg, rgb, md, mdb, lg, xl }

class TxtWidget extends StatelessWidget {
  final String strText;
  final TxtStyle style;
  final Color? color;
  const TxtWidget({
    super.key,
    required this.strText,
    required this.style,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      strText,
      style: getTextStyle(style),
    );
  }

  TextStyle getTextStyle(TxtStyle style) {
    if (style == TxtStyle.sm) {
      return TextStyle(
        fontSize: 14,
        color: color,
      );
    }

    if (style == TxtStyle.rg) {
      return TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: color,
      );
    }

    if (style == TxtStyle.rgb) {
      return TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
      );
    }

    if (style == TxtStyle.md) {
      return TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
      );
    }

    if (style == TxtStyle.mdb) {
      return TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: color,
      );
    }

    if (style == TxtStyle.lg) {
      return const TextStyle(
        fontSize: 20,
      );
    }

    if (style == TxtStyle.xl) {
      return TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: color,
      );
    }

    return const TextStyle();
  }
}
