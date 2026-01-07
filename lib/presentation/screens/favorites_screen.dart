import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/weather_icons.dart';
import '../../core/theme/weather_theme.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/models/favorite_location.dart';
import '../../data/models/weather.dart';
import '../providers/favorites_provider.dart';
import '../providers/favorites_weather_provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/favorite_location_card.dart';
import '../widgets/weather_background.dart';
import 'weather_screen.dart';

/// Screen displaying all favorite locations in a grid.
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesState = ref.watch(favoritesNotifierProvider);
    final theme = WeatherTheme.sunny; // Default theme for favorites screen

    return WeatherScaffold(
      theme: theme,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(context, theme, favoritesState),
            // Content
            Expanded(
              child: favoritesState.isLoading
                  ? _buildLoading(theme)
                  : favoritesState.favorites.isEmpty
                      ? _buildEmptyState(context, theme)
                      : _buildFavoritesGrid(context, ref, favoritesState, theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    WeatherTheme theme,
    FavoritesState state,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: WeatherIcons.arrowBack(
                size: 24,
                color: theme.textColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Favorites',
                  style: AppTextStyles.cityName(theme.textColor),
                ),
                Text(
                  '${state.favorites.length}/${state.maxFavorites} locations',
                  style: AppTextStyles.dateTime(theme.textColor),
                ),
              ],
            ),
          ),
        ],
      ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.2, end: 0),
    );
  }

  Widget _buildLoading(WeatherTheme theme) {
    return Center(
      child: CircularProgressIndicator(
        color: theme.textColor,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WeatherTheme theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WeatherIcons.heartOutline(
              size: 64,
              color: theme.textColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'No favorites yet',
              style: AppTextStyles.cityName(theme.textColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the heart icon on any location to add it to your favorites.',
              style: AppTextStyles.weatherDescription(theme.textColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: theme.textColor,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Text(
                  'Go Back',
                  style: TextStyle(
                    color: theme.gradientColors.first,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
      ),
    );
  }

  Widget _buildFavoritesGrid(
    BuildContext context,
    WidgetRef ref,
    FavoritesState state,
    WeatherTheme theme,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(favoritesWeatherProvider.notifier).refreshAll();
      },
      color: theme.textColor,
      backgroundColor: theme.gradientColors.first,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: state.favorites.length,
        itemBuilder: (context, index) {
          final favorite = state.favorites[index];
          return FavoriteLocationCard(
            favorite: favorite,
            onTap: () => _navigateToLocation(context, ref, favorite),
            onDelete: () => _deleteFavorite(context, ref, favorite.id),
          ).animate(delay: (index * 50).ms).fadeIn(duration: 300.ms).scale(
                begin: const Offset(0.9, 0.9),
                end: const Offset(1, 1),
              );
        },
      ),
    );
  }

  void _navigateToLocation(
    BuildContext context,
    WidgetRef ref,
    FavoriteLocation favorite,
  ) {
    // Create Location from favorite and fetch weather
    final location = Location(
      latitude: favorite.latitude,
      longitude: favorite.longitude,
      name: favorite.name,
      country: favorite.country,
      admin1: favorite.admin1,
      timezone: favorite.timezone,
    );

    // Fetch weather for the selected location
    ref.read(weatherNotifierProvider.notifier).fetchWeather(location);

    // Navigate back to weather screen (skip initial fetch since we already loaded weather)
    Navigator.of(context).pushReplacement(
      FadeSlidePageRoute(page: const WeatherScreen(skipInitialFetch: true)),
    );
  }

  void _deleteFavorite(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'Remove Favorite?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'This location will be removed from your favorites.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Remove',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(favoritesNotifierProvider.notifier).removeFavorite(id);
    }
  }
}
