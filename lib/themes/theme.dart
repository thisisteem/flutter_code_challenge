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
    displayLarge: GoogleFonts.kanit(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    displayMedium: GoogleFonts.kanit(
      fontSize: 24.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    displaySmall: GoogleFonts.kanit(
      fontSize: 24.sp,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    headlineLarge: GoogleFonts.kanit(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headlineMedium: GoogleFonts.kanit(
      fontSize: 22.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    headlineSmall: GoogleFonts.kanit(
      fontSize: 22.sp,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    bodyLarge: GoogleFonts.kanit(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      letterSpacing: 0.01.sp,
    ),
    bodyMedium: GoogleFonts.kanit(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      letterSpacing: 0.01.sp,
    ),
    bodySmall: GoogleFonts.kanit(
      fontSize: 18.sp,
      fontWeight: FontWeight.w300,
      color: Colors.black,
      letterSpacing: 0.01.sp,
    ),
    labelLarge: GoogleFonts.kanit(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      letterSpacing: 0.01.sp,
    ),
    labelMedium: GoogleFonts.kanit(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      letterSpacing: 0.01.sp,
    ),
    labelSmall: GoogleFonts.kanit(
      fontSize: 16.sp,
      fontWeight: FontWeight.w300,
      color: Colors.black,
      letterSpacing: 0.01.sp,
    ),
  );
}
