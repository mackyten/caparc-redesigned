import 'package:caparc/presentation/ca_colors.dart';
import 'package:flutter/material.dart';

double bodyPadding = 16;
double insidePadding = 12;
double iconsSize = 24;
// EdgeInsets borderRadius = const EdgeInsets.all(5);
Size avatarSize = const Size(60, 60);

double titleSize = 18;
double subtitleSize = 16;
double detailSize = 12;
const Duration animationDuration = Duration(milliseconds: 200);

List<BoxShadow>? defaultBoxShadow = const [
  BoxShadow(
    color: Colors.grey,
    offset: Offset(0, 2),
    spreadRadius: 0,
    blurRadius: 1,
  ),
];

BoxShadow paperShadow = const BoxShadow(
  color: Colors.black12,
  offset: Offset(0, 2),
  spreadRadius: 3,
  blurRadius: 3,
);

TextStyle titleStyle = TextStyle(
  color: CAColors.accent,
  fontWeight: FontWeight.w700,
  fontSize: subtitleSize,
);
TextStyle subtitleStyle = const TextStyle(
  color: CAColors.accent,
  fontWeight: FontWeight.w600,
  fontSize: 14,
);

TextStyle hintStyle = const TextStyle(
  color: CAColors.secondary,
  fontWeight: FontWeight.w400,
  fontSize: 10,
);

TextStyle valueStyle = const TextStyle(
  color: CAColors.text,
  fontWeight: FontWeight.w400,
  fontSize: 11,
);
