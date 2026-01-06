import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/favorite_location.dart';
import '../../data/models/weather.dart';
import '../../data/repositories/weather_repository.dart';
import 'weather_provider.dart';
import 'favorites_provider.dart';

/// Cache entry for favorite weather data.
class _CacheEntry {
  final Weather weather;
  final DateTime fetchedAt;

  _CacheEntry(this.weather) : fetchedAt = DateTime.now();

  /// Check if cache is still valid (15 minute TTL).
  bool get isValid =>
      DateTime.now().difference(fetchedAt).inMinutes < 15;
}

/// Notifier for managing weather data for all favorite locations.
class FavoritesWeatherNotifier extends StateNotifier<Map<String, AsyncValue<Weather>>> {
  final WeatherRepository _weatherRepository;
  final Ref _ref;

  /// Cache for weather data with TTL.
  final Map<String, _CacheEntry> _cache = {};

  FavoritesWeatherNotifier(this._weatherRepository, this._ref) : super({}) {
    // Watch favorites and fetch weather when they change
    _ref.listen(favoritesNotifierProvider, (previous, next) {
      _onFavoritesChanged(next.favorites);
    });

    // Initial load
    final favorites = _ref.read(favoritesNotifierProvider).favorites;
    _onFavoritesChanged(favorites);
  }

  void _onFavoritesChanged(List<FavoriteLocation> favorites) {
    // Remove stale entries
    final currentIds = favorites.map((f) => f.id).toSet();
    state = Map.from(state)..removeWhere((key, _) => !currentIds.contains(key));
    _cache.removeWhere((key, _) => !currentIds.contains(key));

    // Fetch weather for new favorites
    for (final favorite in favorites) {
      if (!state.containsKey(favorite.id)) {
        fetchWeatherFor(favorite);
      }
    }
  }

  /// Fetches weather for a specific favorite location.
  Future<void> fetchWeatherFor(FavoriteLocation favorite) async {
    // Check cache first
    final cached = _cache[favorite.id];
    if (cached != null && cached.isValid) {
      state = {...state, favorite.id: AsyncValue.data(cached.weather)};
      return;
    }

    // Set loading state
    state = {...state, favorite.id: const AsyncValue.loading()};

    try {
      final weather = await _weatherRepository.getWeather(
        latitude: favorite.latitude,
        longitude: favorite.longitude,
        timezone: favorite.timezone,
      );

      // Update weather with proper location name from favorite
      final updatedWeather = Weather(
        current: weather.current,
        hourly: weather.hourly,
        daily: weather.daily,
        location: Location(
          latitude: favorite.latitude,
          longitude: favorite.longitude,
          name: favorite.name,
          country: favorite.country,
          admin1: favorite.admin1,
          timezone: favorite.timezone,
        ),
      );

      // Update cache and state
      _cache[favorite.id] = _CacheEntry(updatedWeather);
      state = {...state, favorite.id: AsyncValue.data(updatedWeather)};
    } catch (e, st) {
      state = {...state, favorite.id: AsyncValue.error(e, st)};
    }
  }

  /// Refreshes weather for all favorites.
  Future<void> refreshAll() async {
    // Clear cache
    _cache.clear();

    final favorites = _ref.read(favoritesNotifierProvider).favorites;

    // Set all to loading
    state = {
      for (final favorite in favorites) favorite.id: const AsyncValue.loading(),
    };

    // Fetch all in parallel
    await Future.wait(
      favorites.map((f) => fetchWeatherFor(f)),
    );
  }

  /// Gets weather for a specific favorite, fetching if needed.
  AsyncValue<Weather>? getWeatherFor(String favoriteId) {
    return state[favoriteId];
  }
}

/// Provider for the FavoritesWeatherNotifier.
final favoritesWeatherProvider =
    StateNotifierProvider<FavoritesWeatherNotifier, Map<String, AsyncValue<Weather>>>((ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  return FavoritesWeatherNotifier(weatherRepository, ref);
});

/// Provider for weather data of a specific favorite location.
final favoriteWeatherProvider = Provider.family<AsyncValue<Weather?>, String>((ref, favoriteId) {
  final weatherMap = ref.watch(favoritesWeatherProvider);
  return weatherMap[favoriteId] ?? const AsyncValue.loading();
});
