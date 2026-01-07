import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/weather_codes.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/weather_icons.dart';
import '../../core/theme/weather_theme.dart';
import '../../data/models/favorite_location.dart';
import '../../data/models/weather.dart';
import '../providers/favorites_weather_provider.dart';
import 'animated_weather_icon.dart';

/// A card displaying a favorite location with its current weather.
class FavoriteLocationCard extends ConsumerWidget {
  final FavoriteLocation favorite;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const FavoriteLocationCard({
    super.key,
    required this.favorite,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(favoriteWeatherProvider(favorite.id));

    return weatherAsync.when(
      data: (weather) => _buildCard(context, weather),
      loading: () => _buildLoadingCard(context),
      error: (e, st) => _buildErrorCard(context),
    );
  }

  Widget _buildCard(BuildContext context, Weather? weather) {
    final condition = weather?.resolvedCondition ?? WeatherCondition.clearDay;
    final theme = WeatherTheme.fromCondition(condition);
    final isDay = weather?.current.isDay ?? true;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onDelete,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: theme.gradientColors,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: theme.gradientColors.first.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // City name
                    Text(
                      favorite.name,
                      style: AppTextStyles.cityName(theme.textColor).copyWith(
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (favorite.country != null)
                      Text(
                        favorite.country!,
                        style: AppTextStyles.dateTime(theme.textColor).copyWith(
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const Spacer(),
                    // Weather icon
                    if (weather != null)
                      Center(
                        child: AnimatedWeatherIcon(
                          weatherCode: weather.current.weatherCode,
                          isDay: isDay,
                          size: 48,
                          fallbackColor: theme.textColor,
                        ),
                      ),
                    const Spacer(),
                    // Temperature
                    if (weather != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${weather.current.temperature.round()}°',
                            style: AppTextStyles.temperatureHero(theme.textColor)
                                .copyWith(fontSize: 36),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                weather.current.description,
                                style: AppTextStyles.hourlyTime(theme.textColor)
                                    .copyWith(fontSize: 10),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (weather.daily.isNotEmpty)
                                Text(
                                  'H:${weather.daily.first.temperatureMax.round()}° L:${weather.daily.first.temperatureMin.round()}°',
                                  style: AppTextStyles.hourlyTime(theme.textColor)
                                      .copyWith(fontSize: 10),
                                ),
                            ],
                          ),
                        ],
                      )
                    else
                      Text(
                        'No data',
                        style: AppTextStyles.dateTime(theme.textColor),
                      ),
                  ],
                ),
              ),
              // Delete button
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onDelete,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: theme.textColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: WeatherIcons.close(
                      size: 16,
                      color: theme.textColor.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              favorite.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            )
                .animate(onPlay: (c) => c.repeat())
                .fadeIn(duration: 300.ms)
                .then()
                .fadeOut(duration: 300.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onDelete,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade700,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                favorite.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (favorite.country != null)
                Text(
                  favorite.country!,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              const Spacer(),
              Center(
                child: WeatherIcons.cloudOff(
                  size: 32,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
              const Spacer(),
              const Text(
                'Unable to load weather',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
