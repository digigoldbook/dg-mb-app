import 'package:flutter/material.dart';

class AppIcons {
  static final AppIcons _singleton = AppIcons._internal();
  AppIcons._internal();
  static AppIcons get instance => _singleton;

  final IconData home = Icons.home;
  final IconData person = Icons.person;
  final IconData store = Icons.store;
  final IconData calculator = Icons.calculate;
  final IconData gallery = Icons.image;
  final IconData notificationOutlined = Icons.notifications_outlined;
  final IconData shop = Icons.shop;
  final IconData locationCity = Icons.location_city;
  final IconData number = Icons.numbers;
  final IconData phone = Icons.phone;
}
