// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Weather _$WeatherFromJson(Map<String, dynamic> json) => _Weather(
  current: CurrentWeather.fromJson(json['current'] as Map<String, dynamic>),
  hourly: (json['hourly'] as List<dynamic>)
      .map((e) => HourlyWeather.fromJson(e as Map<String, dynamic>))
      .toList(),
  daily: (json['daily'] as List<dynamic>)
      .map((e) => DailyWeather.fromJson(e as Map<String, dynamic>))
      .toList(),
  location: Location.fromJson(json['location'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WeatherToJson(_Weather instance) => <String, dynamic>{
  'current': instance.current,
  'hourly': instance.hourly,
  'daily': instance.daily,
  'location': instance.location,
};

_CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) =>
    _CurrentWeather(
      temperature: (json['temperature'] as num).toDouble(),
      apparentTemperature: (json['apparentTemperature'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
      weatherCode: (json['weatherCode'] as num).toInt(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      windDirection: (json['windDirection'] as num).toInt(),
      windGusts: (json['windGusts'] as num).toDouble(),
      precipitation: (json['precipitation'] as num).toDouble(),
      cloudCover: (json['cloudCover'] as num).toInt(),
      isDay: json['isDay'] as bool,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$CurrentWeatherToJson(_CurrentWeather instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'apparentTemperature': instance.apparentTemperature,
      'humidity': instance.humidity,
      'weatherCode': instance.weatherCode,
      'windSpeed': instance.windSpeed,
      'windDirection': instance.windDirection,
      'windGusts': instance.windGusts,
      'precipitation': instance.precipitation,
      'cloudCover': instance.cloudCover,
      'isDay': instance.isDay,
      'time': instance.time.toIso8601String(),
    };

_HourlyWeather _$HourlyWeatherFromJson(Map<String, dynamic> json) =>
    _HourlyWeather(
      time: DateTime.parse(json['time'] as String),
      temperature: (json['temperature'] as num).toDouble(),
      apparentTemperature: (json['apparentTemperature'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
      weatherCode: (json['weatherCode'] as num).toInt(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      precipitationProbability: (json['precipitationProbability'] as num)
          .toInt(),
      precipitation: (json['precipitation'] as num).toDouble(),
      isDay: json['isDay'] as bool,
    );

Map<String, dynamic> _$HourlyWeatherToJson(_HourlyWeather instance) =>
    <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'temperature': instance.temperature,
      'apparentTemperature': instance.apparentTemperature,
      'humidity': instance.humidity,
      'weatherCode': instance.weatherCode,
      'windSpeed': instance.windSpeed,
      'precipitationProbability': instance.precipitationProbability,
      'precipitation': instance.precipitation,
      'isDay': instance.isDay,
    };

_DailyWeather _$DailyWeatherFromJson(
  Map<String, dynamic> json,
) => _DailyWeather(
  date: DateTime.parse(json['date'] as String),
  weatherCode: (json['weatherCode'] as num).toInt(),
  temperatureMax: (json['temperatureMax'] as num).toDouble(),
  temperatureMin: (json['temperatureMin'] as num).toDouble(),
  apparentTemperatureMax: (json['apparentTemperatureMax'] as num).toDouble(),
  apparentTemperatureMin: (json['apparentTemperatureMin'] as num).toDouble(),
  sunrise: DateTime.parse(json['sunrise'] as String),
  sunset: DateTime.parse(json['sunset'] as String),
  precipitationSum: (json['precipitationSum'] as num).toDouble(),
  precipitationProbabilityMax: (json['precipitationProbabilityMax'] as num)
      .toInt(),
  windSpeedMax: (json['windSpeedMax'] as num).toDouble(),
);

Map<String, dynamic> _$DailyWeatherToJson(_DailyWeather instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'weatherCode': instance.weatherCode,
      'temperatureMax': instance.temperatureMax,
      'temperatureMin': instance.temperatureMin,
      'apparentTemperatureMax': instance.apparentTemperatureMax,
      'apparentTemperatureMin': instance.apparentTemperatureMin,
      'sunrise': instance.sunrise.toIso8601String(),
      'sunset': instance.sunset.toIso8601String(),
      'precipitationSum': instance.precipitationSum,
      'precipitationProbabilityMax': instance.precipitationProbabilityMax,
      'windSpeedMax': instance.windSpeedMax,
    };

_Location _$LocationFromJson(Map<String, dynamic> json) => _Location(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  name: json['name'] as String,
  country: json['country'] as String?,
  admin1: json['admin1'] as String?,
  timezone: json['timezone'] as String?,
);

Map<String, dynamic> _$LocationToJson(_Location instance) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'name': instance.name,
  'country': instance.country,
  'admin1': instance.admin1,
  'timezone': instance.timezone,
};
