import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class YourBeersTheme {
  static ThemeData themeData() {
    return ThemeData(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      textTheme: textTheme,
    );
  }

  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.sourceSansPro(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    displayMedium: GoogleFonts.sourceSansPro(
      fontSize: 24.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    displaySmall: GoogleFonts.sourceSansPro(
      fontSize: 24.sp,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    headlineLarge: GoogleFonts.sourceSansPro(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headlineMedium: GoogleFonts.sourceSansPro(
      fontSize: 22.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    headlineSmall: GoogleFonts.sourceSansPro(
      fontSize: 22.sp,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    bodyLarge: GoogleFonts.sourceSansPro(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      letterSpacing: 0.01.sp,
    ),
    bodyMedium: GoogleFonts.sourceSansPro(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      letterSpacing: 0.01.sp,
    ),
    bodySmall: GoogleFonts.sourceSansPro(
      fontSize: 18.sp,
      fontWeight: FontWeight.w300,
      color: Colors.black,
      letterSpacing: 0.01.sp,
    ),
    labelLarge: GoogleFonts.sourceSansPro(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      letterSpacing: 0.01.sp,
    ),
    labelMedium: GoogleFonts.sourceSansPro(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      letterSpacing: 0.01.sp,
    ),
    labelSmall: GoogleFonts.sourceSansPro(
      fontSize: 16.sp,
      fontWeight: FontWeight.w300,
      color: Colors.black,
      letterSpacing: 0.01.sp,
    ),
  );
}
