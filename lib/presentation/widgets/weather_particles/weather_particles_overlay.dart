import 'package:flutter/material.dart';

import '../../../core/constants/weather_codes.dart';
import 'rain_particles.dart';
import 'snow_particles.dart';
import 'lightning_effect.dart';
import 'star_field.dart';

/// Overlay that displays weather-appropriate particle effects.
/// Automatically selects rain, snow, lightning, or stars based on condition.
class WeatherParticlesOverlay extends StatelessWidget {
  final WeatherCondition condition;
  final bool isDay;

  const WeatherParticlesOverlay({
    super.key,
    required this.condition,
    required this.isDay,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Night stars (only for clear/partly cloudy nights)
        if (_shouldShowStars()) const StarField(),

        // Rain particles
        if (_shouldShowRain())
          RainParticles(
            intensity: _getRainIntensity(),
            color: Colors.white.withValues(alpha: 0.7),
          ),

        // Snow particles
        if (_shouldShowSnow())
          SnowParticles(
            intensity: _getSnowIntensity(),
          ),

        // Lightning effect
        if (_shouldShowLightning())
          const LightningEffect(
            frequency: 4.0,
          ),
      ],
    );
  }

  bool _shouldShowStars() {
    if (isDay) return false;
    return condition == WeatherCondition.clearNight ||
        condition == WeatherCondition.partlyCloudyNight;
  }

  bool _shouldShowRain() {
    return condition == WeatherCondition.drizzle ||
        condition == WeatherCondition.rain ||
        condition == WeatherCondition.heavyRain ||
        condition == WeatherCondition.thunderstorm ||
        condition == WeatherCondition.sleet;
  }

  double _getRainIntensity() {
    switch (condition) {
      case WeatherCondition.drizzle:
        return 0.3;
      case WeatherCondition.rain:
      case WeatherCondition.sleet:
        return 0.6;
      case WeatherCondition.heavyRain:
      case WeatherCondition.thunderstorm:
        return 1.0;
      default:
        return 0.5;
    }
  }

  bool _shouldShowSnow() {
    return condition == WeatherCondition.snow ||
        condition == WeatherCondition.heavySnow ||
        condition == WeatherCondition.sleet ||
        condition == WeatherCondition.hail;
  }

  double _getSnowIntensity() {
    switch (condition) {
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        return 0.5;
      case WeatherCondition.heavySnow:
      case WeatherCondition.hail:
        return 1.0;
      default:
        return 0.5;
    }
  }

  bool _shouldShowLightning() {
    return condition == WeatherCondition.thunderstorm ||
        condition == WeatherCondition.hail;
  }
}
