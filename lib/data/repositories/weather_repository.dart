import '../models/weather.dart';
import '../models/location_search_result.dart';

/// Abstract repository for weather data.
/// This allows easy switching between different weather API providers.
///
/// Current implementation: OpenMeteoWeatherService
/// Future options: Tomorrow.io, OpenWeather, WeatherAPI, etc.
abstract class WeatherRepository {
  /// Fetches current weather, hourly forecast, and daily forecast
  /// for the given coordinates.
  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
    String? timezone,
  });

  /// Searches for locations by name.
  /// Returns a list of matching locations.
  Future<List<LocationSearchResult>> searchLocations(String query);

  /// Gets weather for a specific location search result.
  Future<Weather> getWeatherForLocation(LocationSearchResult location) {
    return getWeather(
      latitude: location.latitude,
      longitude: location.longitude,
      timezone: location.timezone,
    );
  }
}
