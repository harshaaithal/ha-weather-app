import 'package:flutter/material.dart';
import '../../core/constants/weather_codes.dart';
import '../../core/theme/weather_theme.dart';

/// Animated gradient background that changes based on weather condition.
class WeatherBackground extends StatelessWidget {
  final WeatherTheme theme;
  final Widget child;

  const WeatherBackground({
    super.key,
    required this.theme,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: theme.gradient,
      ),
      child: child,
    );
  }
}

/// Wrapper that provides gradient background with safe area and particle effects.
class WeatherScaffold extends StatelessWidget {
  final WeatherTheme theme;
  final Widget child;
  final bool extendBody;
  final WeatherCondition? condition;
  final bool isDay;

  const WeatherScaffold({
    super.key,
    required this.theme,
    required this.child,
    this.extendBody = true,
    this.condition,
    this.isDay = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: extendBody,
      extendBodyBehindAppBar: true,
      body: WeatherBackground(
        theme: theme,
        child: SafeArea(
          bottom: false,
          child: child,
        ),
      ),
    );
  }
}
