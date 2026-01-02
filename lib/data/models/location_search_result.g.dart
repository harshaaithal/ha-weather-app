// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocationSearchResult _$LocationSearchResultFromJson(
  Map<String, dynamic> json,
) => _LocationSearchResult(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  country: json['country'] as String?,
  countryCode: json['country_code'] as String?,
  admin1: json['admin1'] as String?,
  admin2: json['admin2'] as String?,
  timezone: json['timezone'] as String?,
  population: (json['population'] as num?)?.toInt(),
);

Map<String, dynamic> _$LocationSearchResultToJson(
  _LocationSearchResult instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'country': instance.country,
  'country_code': instance.countryCode,
  'admin1': instance.admin1,
  'admin2': instance.admin2,
  'timezone': instance.timezone,
  'population': instance.population,
};
