import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFont {
  final String text;
  final double fontSize;
  Color? color;
  late Text _logo;
  late TextStyle _title;

  CustomFont({
    this.text = '',
    this.fontSize = 0,
    this.color = Colors.black,
  });

  Text get logo {
    _logo = Text(
      text,
      style: GoogleFonts.anton(
        fontSize: fontSize,
        color: color,
      ),
    );
    return _logo;
  }

  TextStyle get title {
    _title = GoogleFonts.doHyeon(fontSize: 24, color: Colors.black);
    return _title;
  }
}
