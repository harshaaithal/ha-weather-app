import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/weather.dart';

/// 2x2 stats grid showing weather details.
/// Primary stats: Feels like, Wind, Precipitation, Humidity
class StatsGrid extends StatelessWidget {
  final CurrentWeather weather;
  final Color textColor;

  const StatsGrid({
    super.key,
    required this.weather,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.8,
      children: [
        _StatCard(
          icon: Icons.thermostat_outlined,
          label: 'Feels like',
          value: '${weather.apparentTemperature.round()}°',
          textColor: textColor,
        ),
        _StatCard(
          icon: Icons.air,
          label: 'Wind',
          value: '${weather.windSpeed.round()} km/h',
          textColor: textColor,
        ),
        _StatCard(
          icon: Icons.water_drop_outlined,
          label: 'Precipitation',
          value: '${weather.precipitation} mm',
          textColor: textColor,
        ),
        _StatCard(
          icon: Icons.opacity,
          label: 'Humidity',
          value: '${weather.humidity}%',
          textColor: textColor,
        ),
      ]
          .animate(interval: 100.ms)
          .fadeIn(duration: 300.ms)
          .slideY(begin: 0.2, end: 0),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color textColor;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: textColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: textColor.withOpacity(0.7),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.weatherLabel(textColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.weatherValue(textColor),
          ),
        ],
      ),
    );
  }
}
