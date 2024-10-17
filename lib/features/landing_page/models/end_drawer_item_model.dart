import 'package:flutter/material.dart';

class EndDrawerItemModel {
  String title;
  IconData? icon;
  String screen;

  EndDrawerItemModel({
    required this.title,
    required this.screen,
    this.icon,
  });
}
