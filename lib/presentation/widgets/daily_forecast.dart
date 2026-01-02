import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/weather.dart';

/// 7-day forecast list.
class DailyForecast extends StatelessWidget {
  final List<DailyWeather> dailyWeather;
  final Color textColor;

  const DailyForecast({
    super.key,
    required this.dailyWeather,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            '7-Day Forecast',
            style: AppTextStyles.cityName(textColor),
          ),
        ),
        const SizedBox(height: 16),
        ...dailyWeather.asMap().entries.map((entry) {
          final index = entry.key;
          final day = entry.value;
          return _DailyRow(
            day: day,
            textColor: textColor,
            isToday: index == 0,
          )
              .animate(delay: (index * 50).ms)
              .fadeIn(duration: 300.ms)
              .slideX(begin: 0.1, end: 0);
        }),
      ],
    );
  }
}

class _DailyRow extends StatelessWidget {
  final DailyWeather day;
  final Color textColor;
  final bool isToday;

  const _DailyRow({
    required this.day,
    required this.textColor,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    final dayFormat = DateFormat('EEE');
    final dayText = isToday ? 'Today' : dayFormat.format(day.date);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: textColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Day name
          SizedBox(
            width: 60,
            child: Text(
              dayText,
              style: AppTextStyles.dailyDay(textColor),
            ),
          ),
          // Weather icon
          Icon(
            _getWeatherIcon(day.weatherCode),
            color: textColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          // Precipitation probability
          SizedBox(
            width: 45,
            child: Row(
              children: [
                Icon(
                  Icons.water_drop,
                  size: 14,
                  color: textColor.withOpacity(0.6),
                ),
                const SizedBox(width: 2),
                Text(
                  '${day.precipitationProbabilityMax}%',
                  style: AppTextStyles.hourlyTime(textColor),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Temperature range
          Text(
            '${day.temperatureMax.round()}°',
            style: AppTextStyles.dailyTemp(textColor),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 50,
            child: _TemperatureBar(
              min: day.temperatureMin,
              max: day.temperatureMax,
              color: textColor,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${day.temperatureMin.round()}°',
            style: AppTextStyles.dailyTemp(textColor).copyWith(
              color: textColor.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(int code) {
    if (code == 0) {
      return Icons.wb_sunny;
    } else if (code <= 3) {
      return Icons.wb_cloudy;
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

class _TemperatureBar extends StatelessWidget {
  final double min;
  final double max;
  final Color color;

  const _TemperatureBar({
    required this.min,
    required this.max,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.3),
            color.withOpacity(0.8),
          ],
        ),
      ),
    );
  }
}
