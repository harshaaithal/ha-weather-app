import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/weather.dart';
import '../models/location_search_result.dart';
import '../repositories/weather_repository.dart';

/// Open-Meteo API implementation of WeatherRepository.
/// Free, no API key required, 10,000 requests/day limit.
/// https://open-meteo.com/en/docs
class OpenMeteoWeatherService extends WeatherRepository {
  final Dio _dio;

  OpenMeteoWeatherService({Dio? dio}) : _dio = dio ?? Dio();

  @override
  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
    String? timezone,
  }) async {
    final response = await _dio.get(
      '${ApiConstants.openMeteoBaseUrl}${ApiConstants.forecastEndpoint}',
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'current': ApiConstants.currentParams.join(','),
        'hourly': ApiConstants.hourlyParams.join(','),
        'daily': ApiConstants.dailyParams.join(','),
        'timezone': timezone ?? 'auto',
        'forecast_days': 7,
      },
    );

    return _parseWeatherResponse(response.data, latitude, longitude);
  }

  @override
  Future<List<LocationSearchResult>> searchLocations(String query) async {
    if (query.trim().isEmpty) return [];

    final response = await _dio.get(
      '${ApiConstants.geocodingBaseUrl}${ApiConstants.searchEndpoint}',
      queryParameters: {
        'name': query,
        'count': 10,
        'language': 'en',
        'format': 'json',
      },
    );

    final results = response.data['results'] as List<dynamic>?;
    if (results == null) return [];

    return results
        .map((json) => LocationSearchResult.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Weather _parseWeatherResponse(
    Map<String, dynamic> data,
    double latitude,
    double longitude,
  ) {
    final current = _parseCurrentWeather(data);
    final hourly = _parseHourlyWeather(data);
    final daily = _parseDailyWeather(data);

    final location = Location(
      latitude: latitude,
      longitude: longitude,
      name: 'Current Location',
      timezone: data['timezone'] as String?,
    );

    return Weather(
      current: current,
      hourly: hourly,
      daily: daily,
      location: location,
    );
  }

  CurrentWeather _parseCurrentWeather(Map<String, dynamic> data) {
    final current = data['current'] as Map<String, dynamic>;

    return CurrentWeather(
      temperature: (current['temperature_2m'] as num).toDouble(),
      apparentTemperature: (current['apparent_temperature'] as num).toDouble(),
      humidity: (current['relative_humidity_2m'] as num).toInt(),
      weatherCode: (current['weather_code'] as num).toInt(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      windDirection: (current['wind_direction_10m'] as num).toInt(),
      windGusts: (current['wind_gusts_10m'] as num).toDouble(),
      precipitation: (current['precipitation'] as num).toDouble(),
      cloudCover: (current['cloud_cover'] as num).toInt(),
      isDay: (current['is_day'] as num).toInt() == 1,
      time: DateTime.parse(current['time'] as String),
    );
  }

  List<HourlyWeather> _parseHourlyWeather(Map<String, dynamic> data) {
    final hourly = data['hourly'] as Map<String, dynamic>;
    final times = hourly['time'] as List<dynamic>;
    final temperatures = hourly['temperature_2m'] as List<dynamic>;
    final apparentTemperatures = hourly['apparent_temperature'] as List<dynamic>;
    final humidity = hourly['relative_humidity_2m'] as List<dynamic>;
    final weatherCodes = hourly['weather_code'] as List<dynamic>;
    final windSpeeds = hourly['wind_speed_10m'] as List<dynamic>;
    final precipitationProbs = hourly['precipitation_probability'] as List<dynamic>;
    final precipitation = hourly['precipitation'] as List<dynamic>;
    final isDay = hourly['is_day'] as List<dynamic>;

    final List<HourlyWeather> result = [];
    final now = DateTime.now();

    // Only get next 24 hours
    for (int i = 0; i < times.length && result.length < 24; i++) {
      final time = DateTime.parse(times[i] as String);
      if (time.isBefore(now)) continue;

      result.add(HourlyWeather(
        time: time,
        temperature: (temperatures[i] as num).toDouble(),
        apparentTemperature: (apparentTemperatures[i] as num).toDouble(),
        humidity: (humidity[i] as num).toInt(),
        weatherCode: (weatherCodes[i] as num).toInt(),
        windSpeed: (windSpeeds[i] as num).toDouble(),
        precipitationProbability: (precipitationProbs[i] as num?)?.toInt() ?? 0,
        precipitation: (precipitation[i] as num).toDouble(),
        isDay: (isDay[i] as num).toInt() == 1,
      ));
    }

    return result;
  }

  List<DailyWeather> _parseDailyWeather(Map<String, dynamic> data) {
    final daily = data['daily'] as Map<String, dynamic>;
    final times = daily['time'] as List<dynamic>;
    final weatherCodes = daily['weather_code'] as List<dynamic>;
    final tempMax = daily['temperature_2m_max'] as List<dynamic>;
    final tempMin = daily['temperature_2m_min'] as List<dynamic>;
    final apparentMax = daily['apparent_temperature_max'] as List<dynamic>;
    final apparentMin = daily['apparent_temperature_min'] as List<dynamic>;
    final sunrise = daily['sunrise'] as List<dynamic>;
    final sunset = daily['sunset'] as List<dynamic>;
    final precipSum = daily['precipitation_sum'] as List<dynamic>;
    final precipProb = daily['precipitation_probability_max'] as List<dynamic>;
    final windMax = daily['wind_speed_10m_max'] as List<dynamic>;

    final List<DailyWeather> result = [];

    for (int i = 0; i < times.length; i++) {
      result.add(DailyWeather(
        date: DateTime.parse(times[i] as String),
        weatherCode: (weatherCodes[i] as num).toInt(),
        temperatureMax: (tempMax[i] as num).toDouble(),
        temperatureMin: (tempMin[i] as num).toDouble(),
        apparentTemperatureMax: (apparentMax[i] as num).toDouble(),
        apparentTemperatureMin: (apparentMin[i] as num).toDouble(),
        sunrise: DateTime.parse(sunrise[i] as String),
        sunset: DateTime.parse(sunset[i] as String),
        precipitationSum: (precipSum[i] as num).toDouble(),
        precipitationProbabilityMax: (precipProb[i] as num?)?.toInt() ?? 0,
        windSpeedMax: (windMax[i] as num).toDouble(),
      ));
    }

    return result;
  }
}
