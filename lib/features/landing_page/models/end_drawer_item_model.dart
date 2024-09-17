import 'package:flutter/material.dart';

class EndDrawerItemModel {
  String title;
  VoidCallback onTap;
  IconData? icon;
  String screen;

  EndDrawerItemModel({
    required this.onTap,
    required this.title,
    required this.screen,
    this.icon,
  });
}
