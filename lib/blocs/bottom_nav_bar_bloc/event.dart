import 'package:flutter/material.dart';

@immutable
sealed class BottomNavEvent {}

final class SelectItem extends BottomNavEvent {
  final int selected;
  SelectItem(this.selected);
}
