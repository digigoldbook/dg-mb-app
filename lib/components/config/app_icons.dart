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
  final IconData navigation = Icons.navigation;
  final IconData number = Icons.numbers;
  final IconData phone = Icons.phone;
  final IconData email = Icons.mail;
  final IconData security = Icons.security;
  final IconData visibility = Icons.visibility;
  final IconData visibilityoff = Icons.visibility_off;
  final IconData abc = Icons.abc;
  final IconData notification = Icons.notifications;
  final IconData delete = Icons.delete;
}
