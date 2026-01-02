import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/constants/weather_codes.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';

@freezed
sealed class Weather with _$Weather {
  const Weather._();

  const factory Weather({
    required CurrentWeather current,
    required List<HourlyWeather> hourly,
    required List<DailyWeather> daily,
    required Location location,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  /// Gets the resolved weather condition using all available data.
  /// This considers temperature, wind speed, and sunrise/sunset times
  /// for more accurate theming (e.g., showing sunrise theme at dawn).
  WeatherCondition get resolvedCondition {
    // Use today's sunrise/sunset if available
    final today = daily.isNotEmpty ? daily.first : null;
    return current.resolveCondition(
      sunrise: today?.sunrise,
      sunset: today?.sunset,
    );
  }
}

@freezed
sealed class CurrentWeather with _$CurrentWeather {
  const CurrentWeather._();

  const factory CurrentWeather({
    required double temperature,
    required double apparentTemperature,
    required int humidity,
    required int weatherCode,
    required double windSpeed,
    required int windDirection,
    required double windGusts,
    required double precipitation,
    required int cloudCover,
    required bool isDay,
    required DateTime time,
  }) = _CurrentWeather;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);

  /// Basic condition from WMO code only
  WeatherCondition get condition => WeatherCodes.fromWmoCode(weatherCode, isDay: isDay);

  /// Resolved condition considering temperature, wind, and time of day.
  /// Use this for more accurate theming.
  WeatherCondition resolveCondition({
    DateTime? sunrise,
    DateTime? sunset,
  }) {
    return WeatherConditionResolver.resolve(
      wmoCode: weatherCode,
      isDay: isDay,
      temperature: temperature,
      windSpeed: windSpeed,
      currentTime: time,
      sunrise: sunrise,
      sunset: sunset,
    );
  }

  String get description => WeatherCodes.getDescription(weatherCode);
}

@freezed
sealed class HourlyWeather with _$HourlyWeather {
  const HourlyWeather._();

  const factory HourlyWeather({
    required DateTime time,
    required double temperature,
    required double apparentTemperature,
    required int humidity,
    required int weatherCode,
    required double windSpeed,
    required int precipitationProbability,
    required double precipitation,
    required bool isDay,
  }) = _HourlyWeather;

  factory HourlyWeather.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherFromJson(json);

  WeatherCondition get condition => WeatherCodes.fromWmoCode(weatherCode, isDay: isDay);
  String get description => WeatherCodes.getDescription(weatherCode);
}

@freezed
sealed class DailyWeather with _$DailyWeather {
  const DailyWeather._();

  const factory DailyWeather({
    required DateTime date,
    required int weatherCode,
    required double temperatureMax,
    required double temperatureMin,
    required double apparentTemperatureMax,
    required double apparentTemperatureMin,
    required DateTime sunrise,
    required DateTime sunset,
    required double precipitationSum,
    required int precipitationProbabilityMax,
    required double windSpeedMax,
  }) = _DailyWeather;

  factory DailyWeather.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherFromJson(json);

  WeatherCondition get condition => WeatherCodes.fromWmoCode(weatherCode, isDay: true);
  String get description => WeatherCodes.getDescription(weatherCode);
}

@freezed
sealed class Location with _$Location {
  const factory Location({
    required double latitude,
    required double longitude,
    required String name,
    String? country,
    String? admin1, // State/Province
    String? timezone,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
}
