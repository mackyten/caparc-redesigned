import 'package:flutter/material.dart';

class CAColors {
  static const Color white = Colors.white;
  static const Color appBG = Color.fromARGB(255, 244, 247, 246);
  static const Color accent = Color(0xff0e2954);
  static const Color primary = Color(0xff1f6e8c);
  static const Color secondary = Color(0xff2e8a99);
  static const Color error = Color.fromARGB(255, 181, 14, 14);
  static const Color success = Color(0xff1ca568);
  static const Color danger = Color(0xfff93b4c);
  static const Color warning = Color(0xffffc000);
  static const Color placeholder = Color.fromARGB(255, 81, 14, 14);
  static const Color deactivated = Color.fromARGB(255, 158, 158, 158);
  static const Color disabledFields = Color(0xffdcdcdc);

  static const Color textHigh = Colors.black87;
  static Color textMed = Colors.black.withOpacity(0.60);
  static const Color textLow = Colors.black38;
  static Color shadow = Colors.black.withOpacity(.10);

  static const Color text = Color.fromRGBO(133, 140, 160, 1);
  static Color textDarker = Colors.black.withOpacity(.60);
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(i * 0.1);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
