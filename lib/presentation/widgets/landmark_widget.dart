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
    final screenWidth = MediaQuery.of(context).size.width;

    Widget landmark = SizedBox(
      width: screenWidth,
      height: screenWidth * 0.75,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Soft ambient glow behind landmark
          Positioned(
            bottom: 0,
            child: Container(
              width: screenWidth * 0.8,
              height: 100,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    overlayColor.withValues(alpha: 0.35),
                    overlayColor.withValues(alpha: 0.1),
                    overlayColor.withValues(alpha: 0.0),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          // Landmark image with weather-based color overlay
          _assetPath != null && _assetExists
              ? _buildLandmarkImage(overlayColor, theme, screenWidth)
              : _buildFallbackPlaceholder(theme, screenWidth),
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
            end: -6,
            duration: const Duration(seconds: 3),
            curve: Curves.easeInOut,
          ),
    );
  }

  /// Builds the landmark image with weather-based color overlay.
  Widget _buildLandmarkImage(Color overlayColor, WeatherTheme theme, double screenWidth) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        overlayColor.withValues(alpha: 0.15),
        BlendMode.color,
      ),
      child: Image.asset(
        _assetPath!,
        width: screenWidth,
        height: screenWidth * 0.75,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() => _assetExists = false);
            }
          });
          return _buildFallbackPlaceholder(theme, screenWidth);
        },
      ),
    );
  }

  /// Builds a simple placeholder when image loading fails.
  Widget _buildFallbackPlaceholder(WeatherTheme theme, double screenWidth) {
    return Container(
      width: screenWidth * 0.7,
      height: screenWidth * 0.5,
      decoration: BoxDecoration(
        color: theme.textColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Icon(
        Icons.location_city_rounded,
        size: screenWidth * 0.25,
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
