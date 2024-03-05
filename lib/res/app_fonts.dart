import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle headerStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
  }) =>
      GoogleFonts.poppins(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        fontStyle: fontStyle,
      );

  static TextStyle pacificoFont({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
  }) =>
      GoogleFonts.pacifico(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        fontStyle: fontStyle,
      );
}