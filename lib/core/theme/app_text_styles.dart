import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography from STYLE_GUIDE.md
class AppTextStyles {
  AppTextStyles._();

  /// Temperature - 64px, Bold (700), tight letter-spacing for hero card
  static TextStyle temperature(Color color) => GoogleFonts.inter(
        fontSize: 64,
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.0,
        letterSpacing: -2,
      );

  /// City Name - 20px, Semibold (600)
  static TextStyle cityName(Color color) => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
      );

  /// Date/Time - 14px, Regular (400), 70% opacity
  static TextStyle dateTime(Color color) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color.withOpacity(0.7),
      );

  /// Weather Labels - 14px, Regular (400), muted
  static TextStyle weatherLabel(Color color) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color.withOpacity(0.7),
      );

  /// Weather Values - 18px, Semibold (600)
  static TextStyle weatherValue(Color color) => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
      );

  /// Weather Description - 16px, Regular
  static TextStyle weatherDescription(Color color) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
      );

  /// Hourly Temperature - 16px, Semibold
  static TextStyle hourlyTemp(Color color) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      );

  /// Hourly Time - 12px, Regular
  static TextStyle hourlyTime(Color color) => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color.withOpacity(0.7),
      );

  /// Daily Day Name - 16px, Semibold
  static TextStyle dailyDay(Color color) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      );

  /// Daily Temperature - 16px, Regular
  static TextStyle dailyTemp(Color color) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
      );
}
