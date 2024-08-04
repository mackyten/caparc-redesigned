import 'package:caparc/common/values.dart';
import 'package:caparc/presentation/ca_colors.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum TimeOfDay { morning, afternoon, evening }

class TimeOfDayModel {
  TimeOfDay timeOfDay;
  String greeting;
  Icon icon;
  String svg;
  List<Color> colors;

  TimeOfDayModel(
      {required this.timeOfDay,
      required this.greeting,
      required this.icon,
      required this.svg,
      required this.colors});

  static TimeOfDayModel getTimeOfDay(DateTime date) {
    int hour = date.hour;

    TimeOfDayModel response = TimeOfDayModel(
        timeOfDay: TimeOfDay.morning,
        greeting: 'Good Morning!',
        icon: Icon(
          Icons.wb_twilight_rounded,
          color: CAColors.warning,
          size: iconsSize,
        ),
        svg: 'assets/svg/morning.svg',
        colors: const [
          Color.fromRGBO(237, 197, 142, 1),
          Color.fromRGBO(228, 214, 171, 1),
          Color.fromRGBO(230, 224, 198, 1),
        ]);

    if (hour >= 5 && hour < 12) {
      return response;
    } else if (hour >= 12 && hour < 17) {
      return response
        ..greeting = 'Good Afternoon!'
        ..timeOfDay = TimeOfDay.afternoon
        ..icon = const Icon(Icons.wb_sunny_sharp, color: Colors.amber)
        ..svg = 'assets/svg/afternoon.svg'
        ..colors = const [
          // Color.fromRGBO(255, 231, 160, 1),
          Color.fromRGBO(255, 245, 202, 1),
          Color.fromRGBO(255, 245, 202, 1),
        ];
    } else {
      return response
        ..greeting = 'Good Evening!'
        ..timeOfDay = TimeOfDay.evening
        ..icon = const Icon(Icons.nights_stay, color: Colors.yellow)
        ..svg = 'assets/svg/evening.svg'
        ..colors = const [
          Color(0xff868AE8),
          Color(0xffB8B7E8),
          Color(0xffD2C8F7),
        ];
    }
  }
}
