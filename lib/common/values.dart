import 'package:caparc/presentation/ca_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double bodyPadding = 16;
double insidePadding = 12;
double iconsSize = 24;
// EdgeInsets borderRadius = const EdgeInsets.all(5);
Size avatarSize = const Size(60, 60);

double titleSize = 18;
double subtitleSize = 16;
double detailSize = 12;
const Duration animationDuration = Duration(milliseconds: 200);

List<BoxShadow>? defaultBoxShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.25),
    offset: const Offset(0, 4),
    spreadRadius: 0,
    blurRadius: 7,
  ),
];

BoxShadow paperShadow = const BoxShadow(
  color: Colors.black12,
  offset: Offset(0, 2),
  spreadRadius: 3,
  blurRadius: 3,
);

TextStyle titleStyle = GoogleFonts.poppins(
  color: CAColors.accent,
  fontWeight: FontWeight.w700,
  fontSize: subtitleSize,
);
TextStyle subtitleStyle = GoogleFonts.poppins(
  color: CAColors.accent,
  fontWeight: FontWeight.w600,
  fontSize: 14,
);

TextStyle hintStyle = GoogleFonts.poppins(
  color: CAColors.secondary,
  fontWeight: FontWeight.w400,
  fontSize: 10,
);

TextStyle valueStyle = GoogleFonts.poppins(
  color: CAColors.text,
  fontWeight: FontWeight.w400,
  fontSize: 11,
);
