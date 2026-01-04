import 'package:flutter/material.dart';

import '../../../core/constants/weather_codes.dart';
import '../../../core/utils/accessibility_helper.dart';
import '../special_effects/frost_overlay.dart';
import 'rain_particles.dart';
import 'snow_particles.dart';
import 'lightning_effect.dart';
import 'star_field.dart';

/// Overlay that displays weather-appropriate particle effects.
/// Automatically selects rain, snow, lightning, or stars based on condition.
class WeatherParticlesOverlay extends StatefulWidget {
  final WeatherCondition condition;
  final bool isDay;

  const WeatherParticlesOverlay({
    super.key,
    required this.condition,
    required this.isDay,
  });

  @override
  State<WeatherParticlesOverlay> createState() => _WeatherParticlesOverlayState();
}

class _WeatherParticlesOverlayState extends State<WeatherParticlesOverlay> {
  @override
  void didUpdateWidget(WeatherParticlesOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger haptic feedback when weather condition changes
    if (oldWidget.condition != widget.condition) {
      WeatherHaptics.conditionChange();

      // Special haptic for thunderstorm
      if (widget.condition == WeatherCondition.thunderstorm) {
        WeatherHaptics.thunderRumble();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Respect reduced motion preferences
    if (AccessibilityHelper.shouldReduceMotion(context)) {
      return const SizedBox.shrink();
    }

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

        // Frost overlay for extreme cold
        if (_shouldShowFrost())
          FrostOverlay(
            intensity: _getFrostIntensity(),
          ),
      ],
    );
  }

  bool _shouldShowStars() {
    if (widget.isDay) return false;
    return widget.condition == WeatherCondition.clearNight ||
        widget.condition == WeatherCondition.partlyCloudyNight;
  }

  bool _shouldShowRain() {
    return widget.condition == WeatherCondition.drizzle ||
        widget.condition == WeatherCondition.rain ||
        widget.condition == WeatherCondition.heavyRain ||
        widget.condition == WeatherCondition.thunderstorm ||
        widget.condition == WeatherCondition.sleet;
  }

  double _getRainIntensity() {
    switch (widget.condition) {
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
    return widget.condition == WeatherCondition.snow ||
        widget.condition == WeatherCondition.heavySnow ||
        widget.condition == WeatherCondition.sleet ||
        widget.condition == WeatherCondition.hail;
  }

  double _getSnowIntensity() {
    switch (widget.condition) {
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
    return widget.condition == WeatherCondition.thunderstorm ||
        widget.condition == WeatherCondition.hail;
  }

  bool _shouldShowFrost() {
    return widget.condition == WeatherCondition.extremeCold;
  }

  double _getFrostIntensity() {
    return widget.condition == WeatherCondition.extremeCold ? 0.8 : 0.5;
  }
}
