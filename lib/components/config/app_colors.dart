import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _singleton = AppColors._internal();
  AppColors._internal();
  static AppColors get instance => _singleton;

  final Color redColor = const Color(0xffEF5A6F);
  final Color blueColor = const Color(0xff7695FF);
}
