import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/weather.dart';
import 'animated_weather_icon.dart';

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
            ? textColor.withValues(alpha: 0.2)
            : textColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            timeText,
            style: AppTextStyles.hourlyTime(textColor),
          ),
          AnimatedWeatherIcon(
            weatherCode: hour.weatherCode,
            isDay: hour.isDay,
            size: 32,
            fallbackColor: textColor,
          ),
          Text(
            '${hour.temperature.round()}°',
            style: AppTextStyles.hourlyTemp(textColor),
          ),
        ],
      ),
    );
  }
}
