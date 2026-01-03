import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/weather_codes.dart';
import '../../core/theme/weather_theme.dart';
import '../../data/models/weather.dart';
import '../../data/services/landmark_service.dart';

/// Displays a city landmark image with floating animation and weather-based lighting.
/// Falls back to regional/climate-based generic landmarks when city-specific
/// images aren't available. Spins during pull-to-refresh.
class LandmarkWidget extends StatefulWidget {
  final Location location;
  final WeatherCondition condition;
  final bool isDay;
  final bool isRefreshing;

  const LandmarkWidget({
    super.key,
    required this.location,
    required this.condition,
    required this.isDay,
    this.isRefreshing = false,
  });

  @override
  State<LandmarkWidget> createState() => _LandmarkWidgetState();
}

class _LandmarkWidgetState extends State<LandmarkWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _spinController;
  String? _assetPath;
  bool _assetExists = true;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _resolveAsset();
  }

  @override
  void didUpdateWidget(LandmarkWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle refresh spin animation
    if (widget.isRefreshing && !oldWidget.isRefreshing) {
      _spinController.repeat();
    } else if (!widget.isRefreshing && oldWidget.isRefreshing) {
      _spinController.forward().then((_) {
        if (mounted) _spinController.reset();
      });
    }

    // Resolve new asset if location changed
    if (widget.location.name != oldWidget.location.name ||
        widget.location.country != oldWidget.location.country) {
      _resolveAsset();
    }
  }

  void _resolveAsset() {
    _assetPath = LandmarkService.resolveLandmarkPath(
      cityName: widget.location.name,
      country: widget.location.country,
      latitude: widget.location.latitude,
    );
    _assetExists = true;
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = WeatherTheme.fromCondition(widget.condition);
    final overlayColor = _getLightingOverlay();

    Widget landmark = SizedBox(
      width: 300,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow effect behind landmark
          Positioned(
            bottom: 10,
            child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    overlayColor.withValues(alpha: 0.3),
                    overlayColor.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          // Landmark image with color overlay
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: _assetPath != null && _assetExists
                ? ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      overlayColor.withValues(alpha: 0.2),
                      BlendMode.overlay,
                    ),
                    child: Image.asset(
                      _assetPath!,
                      width: 280,
                      height: 200,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Mark asset as non-existent and rebuild
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() => _assetExists = false);
                          }
                        });
                        return _buildFallbackPlaceholder(theme);
                      },
                    ),
                  )
                : _buildFallbackPlaceholder(theme),
          ),
        ],
      ),
    );

    // Add spin animation when refreshing
    landmark = AnimatedBuilder(
      animation: _spinController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _spinController.value * 2 * 3.14159,
          child: child,
        );
      },
      child: landmark,
    );

    // Add floating animation
    return Center(
      child: landmark
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

  /// Builds a simple placeholder when image loading fails.
  Widget _buildFallbackPlaceholder(WeatherTheme theme) {
    return Container(
      width: 280,
      height: 200,
      decoration: BoxDecoration(
        color: theme.textColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        Icons.location_city_rounded,
        size: 80,
        color: theme.textColor.withValues(alpha: 0.3),
      ),
    );
  }

  Color _getLightingOverlay() {
    if (!widget.isDay) {
      return const Color(0xFF1a237e).withValues(alpha: 0.6);
    }

    switch (widget.condition) {
      // Severe weather
      case WeatherCondition.thunderstorm:
        return const Color(0xFF4a148c).withValues(alpha: 0.5);
      case WeatherCondition.hail:
        return const Color(0xFF4a148c).withValues(alpha: 0.4);

      // Precipitation
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

      // Cloudy
      case WeatherCondition.cloudy:
        return const Color(0xFF78909c).withValues(alpha: 0.3);
      case WeatherCondition.partlyCloudyDay:
      case WeatherCondition.partlyCloudyNight:
        return const Color(0xFF78909c).withValues(alpha: 0.2);

      // Clear
      case WeatherCondition.clearDay:
        return const Color(0xFFffab00).withValues(alpha: 0.2);
      case WeatherCondition.clearNight:
        return const Color(0xFF1a237e).withValues(alpha: 0.4);

      // Derived conditions
      case WeatherCondition.sunrise:
        return const Color(0xFFFF8A65).withValues(alpha: 0.4);
      case WeatherCondition.sunset:
        return const Color(0xFFFF7043).withValues(alpha: 0.5);
      case WeatherCondition.extremeHeat:
        return const Color(0xFFFF6F00).withValues(alpha: 0.4);
      case WeatherCondition.extremeCold:
        return const Color(0xFFE1F5FE).withValues(alpha: 0.5);
      case WeatherCondition.windy:
        return const Color(0xFF64B5F6).withValues(alpha: 0.3);
    }
  }
}
