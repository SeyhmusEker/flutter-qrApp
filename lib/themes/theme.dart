import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  // ignore: non_constant_identifier_names
  static ThemeData OnlyTheme = ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xffF7524F),
        titleTextStyle: TextStyle(
          letterSpacing: 8,
          fontSize: 28,
          fontWeight: FontWeight.w400,
          fontFamily: GoogleFonts.oswald().fontFamily,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Color(0xffF7524F),
      ));
}
