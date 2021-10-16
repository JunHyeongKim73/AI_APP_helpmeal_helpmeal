import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFont {
  final double fontSize;
  Color? color;
  late List<Text> _logo;
  late TextStyle _title;

  CustomFont({
    this.fontSize = 0,
    this.color = Colors.black,
  });

  List<Text> get logo {
    _logo = [
      Text(
        'H',
        style: GoogleFonts.anton(
          fontSize: fontSize,
          color: Colors.red[600],
        ),
      ),
      Text(
        'elp',
        style: GoogleFonts.anton(
          fontSize: fontSize - 8,
          color: Colors.black,
        ),
      ),
      Text(
        ' M',
        style: GoogleFonts.anton(
          fontSize: fontSize,
          color: Colors.yellow[700],
        ),
      ),
      Text(
        'eal',
        style: GoogleFonts.anton(
          fontSize: fontSize - 8,
          color: Colors.black,
        ),
      )
    ];
    return _logo;
  }

  TextStyle get title {
    _title = GoogleFonts.doHyeon(fontSize: 24, color: Colors.black);
    return _title;
  }
}
