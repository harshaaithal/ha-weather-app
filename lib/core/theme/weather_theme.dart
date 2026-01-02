import 'package:flutter/material.dart';
import '../constants/weather_codes.dart';

/// Weather-driven theme configuration.
/// Based on STYLE_GUIDE.md specifications.
class WeatherTheme {
  final List<Color> gradientColors;
  final Color textColor;
  final Color secondaryTextColor;
  final bool showParticles;
  final ParticleType? particleType;

  const WeatherTheme({
    required this.gradientColors,
    this.textColor = Colors.white,
    this.secondaryTextColor = Colors.white70,
    this.showParticles = false,
    this.particleType,
  });

  LinearGradient get gradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColors,
      );

  static WeatherTheme fromCondition(WeatherCondition condition) {
    switch (condition) {
      // Clear conditions
      case WeatherCondition.clearDay:
        return sunny;
      case WeatherCondition.clearNight:
        return clearNight;

      // Cloudy conditions
      case WeatherCondition.partlyCloudyDay:
        return partlyCloudy;
      case WeatherCondition.partlyCloudyNight:
        return cloudyNight;
      case WeatherCondition.cloudy:
        return cloudy;

      // Precipitation
      case WeatherCondition.foggy:
        return foggy;
      case WeatherCondition.drizzle:
        return drizzle;
      case WeatherCondition.rain:
        return rainy;
      case WeatherCondition.heavyRain:
        return rainy;
      case WeatherCondition.thunderstorm:
        return thunderstorm;
      case WeatherCondition.snow:
        return snowy;
      case WeatherCondition.heavySnow:
        return blizzard;
      case WeatherCondition.sleet:
        return sleet;
      case WeatherCondition.hail:
        return hail;

      // Derived conditions (time, temperature, wind)
      case WeatherCondition.sunrise:
        return sunrise;
      case WeatherCondition.sunset:
        return sunset;
      case WeatherCondition.windy:
        return windy;
      case WeatherCondition.extremeHeat:
        return extremeHeat;
      case WeatherCondition.extremeCold:
        return extremeCold;
    }
  }

  // ============ Weather Themes from STYLE_GUIDE.md ============

  /// Sunny / Clear Day
  /// Gradient: #0288D1 → #03A9F4 (bright blue)
  static const sunny = WeatherTheme(
    gradientColors: [Color(0xFF0288D1), Color(0xFF03A9F4)],
  );

  /// Rainy
  /// Gradient: #1E3A5F → #2D5A87 (deep navy)
  static const rainy = WeatherTheme(
    gradientColors: [Color(0xFF1E3A5F), Color(0xFF2D5A87)],
    showParticles: true,
    particleType: ParticleType.rain,
  );

  /// Thunderstorm
  /// Gradient: #1A1A2E → #2D3436 (dark charcoal)
  static const thunderstorm = WeatherTheme(
    gradientColors: [Color(0xFF1A1A2E), Color(0xFF2D3436)],
    showParticles: true,
    particleType: ParticleType.rain,
  );

  /// Drizzle / Light Rain
  /// Gradient: #4A6FA5 → #6B8CBE (soft steel blue)
  static const drizzle = WeatherTheme(
    gradientColors: [Color(0xFF4A6FA5), Color(0xFF6B8CBE)],
    showParticles: true,
    particleType: ParticleType.rain,
  );

  /// Cloudy / Overcast
  /// Gradient: #5E35B1 → #7C4DFF (muted purple)
  static const cloudy = WeatherTheme(
    gradientColors: [Color(0xFF5E35B1), Color(0xFF7C4DFF)],
  );

  /// Partly Cloudy
  /// Gradient: #4FC3F7 → #81D4FA (light sky blue)
  static const partlyCloudy = WeatherTheme(
    gradientColors: [Color(0xFF4FC3F7), Color(0xFF81D4FA)],
  );

  /// Snowy
  /// Gradient: #E3F2FD → #BBDEFB (icy white-blue)
  static const snowy = WeatherTheme(
    gradientColors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
    textColor: Color(0xFF1A237E),
    secondaryTextColor: Color(0xFF3949AB),
    showParticles: true,
    particleType: ParticleType.snow,
  );

  /// Blizzard / Heavy Snow
  /// Gradient: #CFD8DC → #90A4AE (white-gray)
  static const blizzard = WeatherTheme(
    gradientColors: [Color(0xFFCFD8DC), Color(0xFF90A4AE)],
    textColor: Color(0xFF263238),
    secondaryTextColor: Color(0xFF455A64),
    showParticles: true,
    particleType: ParticleType.snow,
  );

  /// Foggy / Misty
  /// Gradient: #B0BEC5 → #CFD8DC (soft gray)
  static const foggy = WeatherTheme(
    gradientColors: [Color(0xFFB0BEC5), Color(0xFFCFD8DC)],
    textColor: Color(0xFF37474F),
    secondaryTextColor: Color(0xFF546E7A),
  );

  /// Clear Night
  /// Gradient: #1A1A2E → #16213E (deep navy-black)
  static const clearNight = WeatherTheme(
    gradientColors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
    showParticles: true,
    particleType: ParticleType.stars,
  );

  /// Cloudy Night
  /// Gradient: #263238 → #37474F (charcoal)
  static const cloudyNight = WeatherTheme(
    gradientColors: [Color(0xFF263238), Color(0xFF37474F)],
  );

  /// Sleet / Freezing Rain
  /// Gradient: #78909C → #90A4AE (cold gray-blue)
  static const sleet = WeatherTheme(
    gradientColors: [Color(0xFF78909C), Color(0xFF90A4AE)],
    showParticles: true,
    particleType: ParticleType.rain,
  );

  /// Hail
  /// Gradient: #546E7A → #78909C (dark steel)
  static const hail = WeatherTheme(
    gradientColors: [Color(0xFF546E7A), Color(0xFF78909C)],
    showParticles: true,
    particleType: ParticleType.rain,
  );

  // ============ Derived Weather Themes from STYLE_GUIDE.md ============

  /// Sunrise / Dawn
  /// Gradient: #FF8A65 → #FFB74D → #64B5F6 (orange-gold-blue, 3-stop)
  static const sunrise = WeatherTheme(
    gradientColors: [Color(0xFFFF8A65), Color(0xFFFFB74D), Color(0xFF64B5F6)],
    showParticles: true,
    particleType: ParticleType.sunRays,
  );

  /// Sunset / Dusk
  /// Gradient: #FF7043 → #CE93D8 → #5C6BC0 (orange-pink-purple, 3-stop)
  static const sunset = WeatherTheme(
    gradientColors: [Color(0xFFFF7043), Color(0xFFCE93D8), Color(0xFF5C6BC0)],
    showParticles: true,
    particleType: ParticleType.sunRays,
  );

  /// Windy
  /// Gradient: #64B5F6 → #90CAF9 (breezy blue)
  static const windy = WeatherTheme(
    gradientColors: [Color(0xFF64B5F6), Color(0xFF90CAF9)],
    showParticles: true,
    particleType: ParticleType.wind,
  );

  /// Extreme Heat / Heatwave
  /// Gradient: #FF6F00 → #FF8F00 (intense orange)
  static const extremeHeat = WeatherTheme(
    gradientColors: [Color(0xFFFF6F00), Color(0xFFFF8F00)],
    showParticles: true,
    particleType: ParticleType.heat,
  );

  /// Extreme Cold / Freezing
  /// Gradient: #E1F5FE → #B3E5FC (pale icy blue)
  static const extremeCold = WeatherTheme(
    gradientColors: [Color(0xFFE1F5FE), Color(0xFFB3E5FC)],
    textColor: Color(0xFF0D47A1),
    secondaryTextColor: Color(0xFF1565C0),
    showParticles: true,
    particleType: ParticleType.frost,
  );
}

enum ParticleType {
  rain,
  snow,
  stars,
  sunRays,   // For sunrise/sunset
  wind,      // Horizontal leaves/debris
  heat,      // Heat shimmer effect
  frost,     // Ice crystals on screen edges
}
