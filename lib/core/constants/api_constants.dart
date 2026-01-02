class ApiConstants {
  ApiConstants._();

  // Open-Meteo API
  static const String openMeteoBaseUrl = 'https://api.open-meteo.com/v1';
  static const String forecastEndpoint = '/forecast';

  // Open-Meteo query parameters
  static const List<String> currentParams = [
    'temperature_2m',
    'relative_humidity_2m',
    'apparent_temperature',
    'is_day',
    'precipitation',
    'rain',
    'showers',
    'snowfall',
    'weather_code',
    'cloud_cover',
    'wind_speed_10m',
    'wind_direction_10m',
    'wind_gusts_10m',
  ];

  static const List<String> hourlyParams = [
    'temperature_2m',
    'relative_humidity_2m',
    'apparent_temperature',
    'precipitation_probability',
    'precipitation',
    'weather_code',
    'wind_speed_10m',
    'is_day',
  ];

  static const List<String> dailyParams = [
    'weather_code',
    'temperature_2m_max',
    'temperature_2m_min',
    'apparent_temperature_max',
    'apparent_temperature_min',
    'sunrise',
    'sunset',
    'precipitation_sum',
    'precipitation_probability_max',
    'wind_speed_10m_max',
  ];

  // Geocoding API
  static const String geocodingBaseUrl = 'https://geocoding-api.open-meteo.com/v1';
  static const String searchEndpoint = '/search';
}
