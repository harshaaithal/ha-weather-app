import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../core/constants/weather_codes.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/weather_icons.dart';
import '../../core/theme/weather_theme.dart';
import '../../core/utils/accessibility_helper.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/models/weather.dart';
import '../providers/weather_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/weather_background.dart';
import '../widgets/stats_grid.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/daily_forecast.dart';
import '../widgets/landmark_widget.dart';
import '../widgets/animated_weather_icon.dart';
import 'city_search_screen.dart';
import 'favorites_screen.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  /// If true, skip fetching current location weather on startup.
  /// Used when navigating from favorites or search with pre-loaded weather.
  final bool skipInitialFetch;

  const WeatherScreen({super.key, this.skipInitialFetch = false});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch weather for current location on startup (unless skipped)
    if (!widget.skipInitialFetch) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(weatherNotifierProvider.notifier).fetchWeatherForCurrentLocation();
      });
    }
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
    // Use resolvedCondition for accurate theming based on temperature, wind, time
    final condition = weather.resolvedCondition;
    final theme = WeatherTheme.fromCondition(condition);
    final isRefreshing = ref.watch(isRefreshingProvider);

    return WeatherScaffold(
      theme: theme,
      condition: condition,
      isDay: weather.current.isDay,
      child: Stack(
        children: [
          // Hero content - single screen layout
          RefreshIndicator(
            onRefresh: () async {
              ref.read(isRefreshingProvider.notifier).state = true;
              await ref.read(weatherNotifierProvider.notifier).refresh();
              ref.read(isRefreshingProvider.notifier).state = false;
              await WeatherHaptics.refreshComplete();
            },
            color: theme.textColor,
            backgroundColor: theme.gradientColors.first,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                // Ensure content fills screen for pull-to-refresh
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top - 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Location & Date
                    _buildHeader(weather, theme),
                    const SizedBox(height: 24),
                    // Temperature + Landmark Row - takes available space
                    Expanded(
                      child: _buildHeroRow(weather, theme, condition, isRefreshing),
                    ),
                    const SizedBox(height: 16),
                    // Stats Grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: StatsGrid(
                        weather: weather.current,
                        textColor: theme.textColor,
                      ),
                    ),
                    const SizedBox(height: 80), // Space for sheet handle
                  ],
                ),
              ),
            ),
          ),
          // Bottom sheet for hourly/daily forecasts
          _buildForecastSheet(weather, theme),
        ],
      ),
    );
  }

  Widget _buildForecastSheet(Weather weather, WeatherTheme theme) {
    return DraggableScrollableSheet(
      initialChildSize: 0.12,
      minChildSize: 0.12,
      maxChildSize: 0.75,
      snap: true,
      snapSizes: const [0.12, 0.45, 0.75],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.gradientColors.last.withValues(alpha: 0.95),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.zero,
            children: [
              // Drag handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.textColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Sheet title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text(
                  'Forecast',
                  style: AppTextStyles.cityName(theme.textColor),
                ),
              ),
              const SizedBox(height: 8),
              // Hourly Forecast
              HourlyForecast(
                hourlyWeather: weather.hourly,
                textColor: theme.textColor,
              ),
              const SizedBox(height: 24),
              // Daily Forecast
              DailyForecast(
                dailyWeather: weather.daily,
                textColor: theme.textColor,
              ),
              const SizedBox(height: 34),
            ],
          ),
        );
      },
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
              WeatherIcons.locationPin(
                size: 20,
                color: theme.textColor.withValues(alpha: 0.8),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  weather.location.name,
                  style: AppTextStyles.cityName(theme.textColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Favorites button (toggle)
              _buildFavoriteButton(weather, theme),
              // Favorites list button
              GestureDetector(
                onTap: () => _openFavorites(),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: WeatherIcons.grid(
                    size: 24,
                    color: theme.textColor.withValues(alpha: 0.8),
                  ),
                ),
              ),
              // Search button - custom tap target instead of Material IconButton
              GestureDetector(
                onTap: () => _openCitySearch(),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: WeatherIcons.search(
                    size: 24,
                    color: theme.textColor.withValues(alpha: 0.8),
                  ),
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

  void _openCitySearch() {
    Navigator.of(context).push(
      FadeSlidePageRoute(page: const CitySearchScreen()),
    );
  }

  void _openFavorites() {
    Navigator.of(context).push(
      FadeSlidePageRoute(page: const FavoritesScreen()),
    );
  }

  Widget _buildFavoriteButton(Weather weather, WeatherTheme theme) {
    final isFavorite = ref.watch(isCurrentLocationFavoriteProvider(weather));
    final favoritesState = ref.watch(favoritesNotifierProvider);

    return GestureDetector(
      onTap: () async {
        final notifier = ref.read(favoritesNotifierProvider.notifier);
        final success = await notifier.toggleFavorite(weather);

        if (!mounted) return;

        final wasFavorite = isFavorite;
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                wasFavorite
                    ? 'Removed from favorites'
                    : 'Added to favorites (${favoritesState.favorites.length + 1}/${favoritesState.maxFavorites})',
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: theme.gradientColors.last,
              duration: const Duration(seconds: 2),
            ),
          );
          await WeatherHaptics.light();
        } else if (!wasFavorite && !favoritesState.canAddMore) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Maximum ${favoritesState.maxFavorites} favorites reached. Upgrade to Pro for more!',
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.orange.shade700,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: isFavorite
            ? WeatherIcons.heartFilled(
                size: 24,
                color: Colors.redAccent,
              )
            : WeatherIcons.heartOutline(
                size: 24,
                color: theme.textColor.withValues(alpha: 0.8),
              ),
      ),
    ).animate(target: isFavorite ? 1 : 0).scale(
          begin: const Offset(1, 1),
          end: const Offset(1.1, 1.1),
          duration: 150.ms,
          curve: Curves.easeOut,
        );
  }

  Widget _buildHeroRow(
    Weather weather,
    WeatherTheme theme,
    WeatherCondition condition,
    bool isRefreshing,
  ) {
    // Semi-transparent background color that complements the gradient
    final cardColor = theme.textColor.withValues(alpha: 0.08);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: theme.textColor.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(31),
          child: Stack(
            children: [
              // Landmark as background (full size)
              Positioned.fill(
                child: LandmarkWidget(
                  location: weather.location,
                  condition: condition,
                  isDay: weather.current.isDay,
                  isRefreshing: isRefreshing,
                ),
              ),
              // Animated weather icon in top-right corner
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.gradientColors.first.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: AnimatedWeatherIcon(
                    weatherCode: weather.current.weatherCode,
                    isDay: weather.current.isDay,
                    size: 56,
                    fallbackColor: theme.textColor,
                  ),
                ).animate().fadeIn(delay: 400.ms, duration: 300.ms).scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                    ),
              ),
              // Temperature overlay on top
              Positioned(
                left: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Temperature with background pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.gradientColors.first.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        '${weather.current.temperature.round()}°',
                        style: AppTextStyles.temperatureHero(theme.textColor),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
                    const SizedBox(height: 8),
                    // Weather description with background pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.gradientColors.first.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        weather.current.description,
                        style: AppTextStyles.weatherDescription(theme.textColor),
                      ),
                    ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
                    const SizedBox(height: 8),
                    // High/Low with background pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.gradientColors.first.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'H:${weather.daily.first.temperatureMax.round()}° L:${weather.daily.first.temperatureMin.round()}°',
                        style: AppTextStyles.dateTime(theme.textColor).copyWith(
                          color: theme.textColor,
                        ),
                      ),
                    ).animate().fadeIn(delay: 300.ms, duration: 300.ms),
                  ],
                ),
              ),
            ],
          ),
        ),
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
              WeatherIcons.cloudOff(
                size: 64,
                color: theme.textColor.withValues(alpha: 0.7),
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
              // Custom retry button instead of Material ElevatedButton
              GestureDetector(
                onTap: () {
                  ref.read(weatherNotifierProvider.notifier).fetchWeatherForCurrentLocation();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: theme.textColor,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      WeatherIcons.refresh(size: 20, color: theme.gradientColors.first),
                      const SizedBox(width: 8),
                      Text(
                        'Try Again',
                        style: TextStyle(
                          color: theme.gradientColors.first,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
