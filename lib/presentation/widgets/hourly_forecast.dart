import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/weather.dart';

/// Horizontal scrolling hourly forecast.
class HourlyForecast extends StatelessWidget {
  final List<HourlyWeather> hourlyWeather;
  final Color textColor;

  const HourlyForecast({
    super.key,
    required this.hourlyWeather,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: hourlyWeather.length,
        itemBuilder: (context, index) {
          final hour = hourlyWeather[index];
          return _HourlyCard(
            hour: hour,
            textColor: textColor,
            isFirst: index == 0,
          )
              .animate(delay: (index * 50).ms)
              .fadeIn(duration: 300.ms)
              .slideX(begin: 0.2, end: 0);
        },
      ),
    );
  }
}

class _HourlyCard extends StatelessWidget {
  final HourlyWeather hour;
  final Color textColor;
  final bool isFirst;

  const _HourlyCard({
    required this.hour,
    required this.textColor,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('HH:mm');
    final timeText = isFirst ? 'Now' : timeFormat.format(hour.time);

    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: isFirst
            ? textColor.withOpacity(0.2)
            : textColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            timeText,
            style: AppTextStyles.hourlyTime(textColor),
          ),
          Icon(
            _getWeatherIcon(hour.weatherCode, hour.isDay),
            color: textColor,
            size: 28,
          ),
          Text(
            '${hour.temperature.round()}°',
            style: AppTextStyles.hourlyTemp(textColor),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(int code, bool isDay) {
    // Simplified icon mapping
    if (code == 0) {
      return isDay ? Icons.wb_sunny : Icons.nightlight_round;
    } else if (code <= 3) {
      return isDay ? Icons.wb_cloudy : Icons.nights_stay;
    } else if (code <= 48) {
      return Icons.foggy;
    } else if (code <= 67) {
      return Icons.water_drop;
    } else if (code <= 77) {
      return Icons.ac_unit;
    } else if (code <= 82) {
      return Icons.grain;
    } else if (code <= 86) {
      return Icons.ac_unit;
    } else {
      return Icons.thunderstorm;
    }
  }
}
