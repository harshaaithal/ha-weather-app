import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/weather_codes.dart';
import '../../core/theme/weather_theme.dart';

/// A placeholder landmark widget that displays a stylized city silhouette
/// with weather-appropriate lighting and a subtle floating animation.
class LandmarkPlaceholder extends StatelessWidget {
  final WeatherCondition condition;
  final bool isDay;

  const LandmarkPlaceholder({
    super.key,
    required this.condition,
    required this.isDay,
  });

  @override
  Widget build(BuildContext context) {
    final theme = WeatherTheme.fromCondition(condition);
    final overlayColor = _getLightingOverlay();

    return Center(
      child: SizedBox(
        width: 280,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // City silhouette with lighting overlay
            CustomPaint(
              size: const Size(280, 180),
              painter: _CitySilhouettePainter(
                baseColor: theme.textColor.withValues(alpha: 0.3),
                overlayColor: overlayColor,
              ),
            ),
            // Glow effect behind buildings
            Positioned(
              bottom: 0,
              child: Container(
                width: 240,
                height: 40,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      overlayColor.withValues(alpha: 0.4),
                      overlayColor.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
          .animate(
            onPlay: (controller) => controller.repeat(reverse: true),
          )
          .moveY(
            begin: 0,
            end: -4,
            duration: const Duration(seconds: 3),
            curve: Curves.easeInOut,
          ),
    );
  }

  Color _getLightingOverlay() {
    if (!isDay) {
      // Night time - bluish/purple tint
      return const Color(0xFF1a237e).withValues(alpha: 0.6);
    }

    switch (condition) {
      case WeatherCondition.thunderstorm:
        return const Color(0xFF4a148c).withValues(alpha: 0.5);
      case WeatherCondition.hail:
        return const Color(0xFF4a148c).withValues(alpha: 0.4);
      case WeatherCondition.rain:
      case WeatherCondition.heavyRain:
      case WeatherCondition.drizzle:
        return const Color(0xFF37474f).withValues(alpha: 0.4);
      case WeatherCondition.snow:
      case WeatherCondition.heavySnow:
      case WeatherCondition.sleet:
        return const Color(0xFFe3f2fd).withValues(alpha: 0.3);
      case WeatherCondition.foggy:
        return const Color(0xFF90a4ae).withValues(alpha: 0.5);
      case WeatherCondition.cloudy:
        return const Color(0xFF78909c).withValues(alpha: 0.3);
      case WeatherCondition.partlyCloudyDay:
      case WeatherCondition.partlyCloudyNight:
        return const Color(0xFF78909c).withValues(alpha: 0.2);
      case WeatherCondition.clearDay:
        return const Color(0xFFffab00).withValues(alpha: 0.2);
      case WeatherCondition.clearNight:
        return const Color(0xFF1a237e).withValues(alpha: 0.4);
    }
  }
}

/// Custom painter that draws a stylized city skyline silhouette
class _CitySilhouettePainter extends CustomPainter {
  final Color baseColor;
  final Color overlayColor;

  _CitySilhouettePainter({
    required this.baseColor,
    required this.overlayColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.fill;

    final overlayPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    // Define building shapes (isometric-style city)
    final buildings = [
      // Left building (short)
      _Building(x: 20, width: 35, height: 60),
      // Left-center building (medium)
      _Building(x: 50, width: 40, height: 90),
      // Center-left tower (tall with spire)
      _Building(x: 85, width: 30, height: 130, hasSpire: true),
      // Center building (wide, medium)
      _Building(x: 110, width: 50, height: 80),
      // Center-right tower (tallest)
      _Building(x: 155, width: 35, height: 150, hasSpire: true),
      // Right-center building (medium)
      _Building(x: 185, width: 45, height: 100),
      // Right building (short)
      _Building(x: 225, width: 35, height: 55),
    ];

    final baseY = size.height;

    // Draw buildings from back to front for proper layering
    for (final building in buildings) {
      final path = Path();

      if (building.hasSpire) {
        // Building with spire
        final spireHeight = building.height * 0.15;
        path.moveTo(building.x, baseY);
        path.lineTo(building.x, baseY - building.height + spireHeight);
        path.lineTo(building.x + building.width / 2, baseY - building.height);
        path.lineTo(
            building.x + building.width, baseY - building.height + spireHeight);
        path.lineTo(building.x + building.width, baseY);
        path.close();
      } else {
        // Regular rectangular building
        path.addRect(Rect.fromLTWH(
          building.x,
          baseY - building.height,
          building.width,
          building.height,
        ));
      }

      // Draw base building
      canvas.drawPath(path, paint);
      // Draw lighting overlay
      canvas.drawPath(path, overlayPaint);

      // Draw windows (small rectangles)
      _drawWindows(canvas, building, baseY);
    }
  }

  void _drawWindows(Canvas canvas, _Building building, double baseY) {
    final windowPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    const windowWidth = 4.0;
    const windowHeight = 6.0;
    const windowSpacingX = 10.0;
    const windowSpacingY = 14.0;

    final startY = baseY - building.height + 20;
    final endY = baseY - 10;
    final startX = building.x + 6;
    final endX = building.x + building.width - 6;

    for (double y = startY; y < endY; y += windowSpacingY) {
      for (double x = startX; x < endX; x += windowSpacingX) {
        canvas.drawRect(
          Rect.fromLTWH(x, y, windowWidth, windowHeight),
          windowPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CitySilhouettePainter oldDelegate) {
    return oldDelegate.baseColor != baseColor ||
        oldDelegate.overlayColor != overlayColor;
  }
}

class _Building {
  final double x;
  final double width;
  final double height;
  final bool hasSpire;

  const _Building({
    required this.x,
    required this.width,
    required this.height,
    this.hasSpire = false,
  });
}
