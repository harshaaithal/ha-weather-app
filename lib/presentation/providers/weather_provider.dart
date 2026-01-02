import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/weather.dart';
import '../../data/models/location_search_result.dart';
import '../../data/repositories/weather_repository.dart';
import '../../data/services/open_meteo_service.dart';
import '../../data/services/location_service.dart';

/// Provider for the WeatherRepository implementation.
/// Change this to switch between different weather API providers.
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return OpenMeteoWeatherService();
});

/// Provider for the LocationService.
final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

/// Provider for the current selected location.
final selectedLocationProvider = StateProvider<Location?>((ref) => null);

/// Provider for the weather data.
/// Automatically fetches weather when location changes.
final weatherProvider = FutureProvider.autoDispose<Weather?>((ref) async {
  final location = ref.watch(selectedLocationProvider);
  if (location == null) return null;

  final repository = ref.watch(weatherRepositoryProvider);
  return await repository.getWeather(
    latitude: location.latitude,
    longitude: location.longitude,
    timezone: location.timezone,
  );
});

/// Provider for location search results.
final locationSearchQueryProvider = StateProvider<String>((ref) => '');

final locationSearchResultsProvider = FutureProvider.autoDispose<List<LocationSearchResult>>((ref) async {
  final query = ref.watch(locationSearchQueryProvider);
  if (query.trim().length < 2) return [];

  final repository = ref.watch(weatherRepositoryProvider);
  return await repository.searchLocations(query);
});

/// Provider for fetching current device location.
final currentLocationProvider = FutureProvider.autoDispose<Location>((ref) async {
  final locationService = ref.watch(locationServiceProvider);
  return await locationService.getCurrentLocation();
});

/// State notifier for managing weather state with loading/error handling.
class WeatherNotifier extends StateNotifier<AsyncValue<Weather?>> {
  final WeatherRepository _repository;
  final LocationService _locationService;

  WeatherNotifier(this._repository, this._locationService)
      : super(const AsyncValue.data(null));

  /// Fetches weather for the given location.
  Future<void> fetchWeather(Location location) async {
    state = const AsyncValue.loading();
    try {
      final weather = await _repository.getWeather(
        latitude: location.latitude,
        longitude: location.longitude,
        timezone: location.timezone,
      );
      state = AsyncValue.data(weather);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Fetches weather for current device location.
  Future<void> fetchWeatherForCurrentLocation() async {
    state = const AsyncValue.loading();
    try {
      final location = await _locationService.getCurrentLocation();
      final weather = await _repository.getWeather(
        latitude: location.latitude,
        longitude: location.longitude,
      );
      // Update weather with proper location name
      state = AsyncValue.data(Weather(
        current: weather.current,
        hourly: weather.hourly,
        daily: weather.daily,
        location: location,
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Fetches weather for a search result location.
  Future<void> fetchWeatherForLocation(LocationSearchResult searchResult) async {
    state = const AsyncValue.loading();
    try {
      final weather = await _repository.getWeatherForLocation(searchResult);
      // Update weather with location from search result
      state = AsyncValue.data(Weather(
        current: weather.current,
        hourly: weather.hourly,
        daily: weather.daily,
        location: Location(
          latitude: searchResult.latitude,
          longitude: searchResult.longitude,
          name: searchResult.name,
          country: searchResult.country,
          admin1: searchResult.admin1,
          timezone: searchResult.timezone,
        ),
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Refreshes weather data for the current location.
  Future<void> refresh() async {
    final currentWeather = state.valueOrNull;
    if (currentWeather != null) {
      await fetchWeather(currentWeather.location);
    }
  }
}

/// Provider for the WeatherNotifier.
final weatherNotifierProvider =
    StateNotifierProvider<WeatherNotifier, AsyncValue<Weather?>>((ref) {
  final repository = ref.watch(weatherRepositoryProvider);
  final locationService = ref.watch(locationServiceProvider);
  return WeatherNotifier(repository, locationService);
});
