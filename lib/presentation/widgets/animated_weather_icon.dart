import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/theme/weather_icons.dart';

/// Animated weather icon using Lottie animations.
/// Falls back to static WeatherIcons if animation fails to load.
class AnimatedWeatherIcon extends StatelessWidget {
  final int weatherCode;
  final bool isDay;
  final double size;
  final Color? fallbackColor;

  const AnimatedWeatherIcon({
    super.key,
    required this.weatherCode,
    required this.isDay,
    this.size = 64,
    this.fallbackColor,
  });

  @override
  Widget build(BuildContext context) {
    final assetPath = _getAnimationPath(weatherCode, isDay);

    return SizedBox(
      width: size,
      height: size,
      child: Lottie.asset(
        assetPath,
        width: size,
        height: size,
        fit: BoxFit.contain,
        repeat: true,
        animate: true,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to static icon on error
          return WeatherIcons.fromWeatherCode(
            weatherCode,
            size: size,
            color: fallbackColor ?? Colors.white,
            isDay: isDay,
          );
        },
        frameBuilder: (context, child, composition) {
          if (composition == null) {
            // Show static icon while loading
            return WeatherIcons.fromWeatherCode(
              weatherCode,
              size: size,
              color: fallbackColor ?? Colors.white,
              isDay: isDay,
            );
          }
          return child;
        },
      ),
    );
  }

  /// Maps WMO weather code to Lottie animation asset path.
  String _getAnimationPath(int code, bool isDay) {
    // WMO Weather Codes:
    // 0: Clear sky
    // 1-3: Partly cloudy
    // 45, 48: Fog
    // 51-57: Drizzle
    // 61-67: Rain
    // 71-77: Snow
    // 80-82: Rain showers
    // 85-86: Snow showers
    // 95, 96, 99: Thunderstorm

    if (code == 0) {
      // Clear sky
      return isDay
          ? 'assets/animations/weather/sunny.json'
          : 'assets/animations/weather/clear_night.json';
    } else if (code <= 3) {
      // Partly cloudy
      return isDay
          ? 'assets/animations/weather/partly_cloudy.json'
          : 'assets/animations/weather/cloudy_night.json';
    } else if (code <= 48) {
      // Fog
      return 'assets/animations/weather/fog.json';
    } else if (code <= 67) {
      // Drizzle and Rain
      return 'assets/animations/weather/rain.json';
    } else if (code <= 77) {
      // Snow
      return 'assets/animations/weather/snow.json';
    } else if (code <= 82) {
      // Rain showers
      return 'assets/animations/weather/rain.json';
    } else if (code <= 86) {
      // Snow showers
      return 'assets/animations/weather/snow.json';
    } else {
      // Thunderstorm (95, 96, 99)
      return 'assets/animations/weather/thunderstorm.json';
    }
  }
}

/// Available Lottie weather animations.
/// Use these constants for direct access to specific animations.
class WeatherAnimations {
  WeatherAnimations._();

  static const String sunny = 'assets/animations/weather/sunny.json';
  static const String clearNight = 'assets/animations/weather/clear_night.json';
  static const String partlyCloudy = 'assets/animations/weather/partly_cloudy.json';
  static const String cloudyNight = 'assets/animations/weather/cloudy_night.json';
  static const String rain = 'assets/animations/weather/rain.json';
  static const String snow = 'assets/animations/weather/snow.json';
  static const String thunderstorm = 'assets/animations/weather/thunderstorm.json';
  static const String fog = 'assets/animations/weather/fog.json';
  static const String windy = 'assets/animations/weather/windy.json';

  /// Get animation path from weather code and day/night status.
  static String fromWeatherCode(int code, {required bool isDay}) {
    if (code == 0) {
      return isDay ? sunny : clearNight;
    } else if (code <= 3) {
      return isDay ? partlyCloudy : cloudyNight;
    } else if (code <= 48) {
      return fog;
    } else if (code <= 67) {
      return rain;
    } else if (code <= 77) {
      return snow;
    } else if (code <= 82) {
      return rain;
    } else if (code <= 86) {
      return snow;
    } else {
      return thunderstorm;
    }
  }
}
