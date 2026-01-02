import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/weather_theme.dart';
import '../../data/models/weather.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_background.dart';
import '../widgets/stats_grid.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/daily_forecast.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch weather for current location on startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(weatherNotifierProvider.notifier).fetchWeatherForCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherNotifierProvider);

    return weatherState.when(
      data: (weather) {
        if (weather == null) {
          return _buildLoading(WeatherTheme.sunny);
        }
        return _buildWeatherContent(weather);
      },
      loading: () => _buildLoading(WeatherTheme.sunny),
      error: (error, stack) => _buildError(error.toString()),
    );
  }

  Widget _buildWeatherContent(Weather weather) {
    final theme = WeatherTheme.fromCondition(weather.current.condition);

    return WeatherScaffold(
      theme: theme,
      child: RefreshIndicator(
        onRefresh: () => ref.read(weatherNotifierProvider.notifier).refresh(),
        color: theme.textColor,
        backgroundColor: theme.gradientColors.first,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Location & Date
                _buildHeader(weather, theme),
                const SizedBox(height: 32),
                // Temperature Hero
                _buildTemperatureHero(weather, theme),
                const SizedBox(height: 32),
                // Stats Grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: StatsGrid(
                    weather: weather.current,
                    textColor: theme.textColor,
                  ),
                ),
                const SizedBox(height: 32),
                // Hourly Forecast
                _buildSectionTitle('Hourly', theme),
                const SizedBox(height: 12),
                HourlyForecast(
                  hourlyWeather: weather.hourly,
                  textColor: theme.textColor,
                ),
                const SizedBox(height: 32),
                // Daily Forecast
                DailyForecast(
                  dailyWeather: weather.daily,
                  textColor: theme.textColor,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Weather weather, WeatherTheme theme) {
    final dateFormat = DateFormat('EEEE, d MMMM');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 20,
                color: theme.textColor.withOpacity(0.8),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  weather.location.name,
                  style: AppTextStyles.cityName(theme.textColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            dateFormat.format(DateTime.now()),
            style: AppTextStyles.dateTime(theme.textColor),
          ),
        ],
      ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.2, end: 0),
    );
  }

  Widget _buildTemperatureHero(Weather weather, WeatherTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${weather.current.temperature.round()}°',
            style: AppTextStyles.temperature(theme.textColor),
          )
              .animate()
              .fadeIn(duration: 400.ms)
              .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
          const SizedBox(height: 8),
          Text(
            weather.current.description,
            style: AppTextStyles.weatherDescription(theme.textColor),
          ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
          const SizedBox(height: 4),
          Text(
            'H:${weather.daily.first.temperatureMax.round()}° L:${weather.daily.first.temperatureMin.round()}°',
            style: AppTextStyles.dateTime(theme.textColor),
          ).animate().fadeIn(delay: 300.ms, duration: 300.ms),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, WeatherTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        title,
        style: AppTextStyles.cityName(theme.textColor),
      ),
    );
  }

  Widget _buildLoading(WeatherTheme theme) {
    return WeatherScaffold(
      theme: theme,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: theme.textColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Getting weather...',
              style: AppTextStyles.weatherDescription(theme.textColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String error) {
    final theme = WeatherTheme.cloudy;

    return WeatherScaffold(
      theme: theme,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_off,
                size: 64,
                color: theme.textColor.withOpacity(0.7),
              ),
              const SizedBox(height: 16),
              Text(
                'Unable to get weather',
                style: AppTextStyles.cityName(theme.textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                error,
                style: AppTextStyles.weatherDescription(theme.textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(weatherNotifierProvider.notifier).fetchWeatherForCurrentLocation();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.textColor,
                  foregroundColor: theme.gradientColors.first,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
