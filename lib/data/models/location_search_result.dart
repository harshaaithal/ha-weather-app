import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_search_result.freezed.dart';
part 'location_search_result.g.dart';

@freezed
sealed class LocationSearchResult with _$LocationSearchResult {
  const factory LocationSearchResult({
    required int id,
    required String name,
    required double latitude,
    required double longitude,
    String? country,
    @JsonKey(name: 'country_code') String? countryCode,
    String? admin1, // State/Province
    String? admin2, // County/District
    String? timezone,
    int? population,
  }) = _LocationSearchResult;

  factory LocationSearchResult.fromJson(Map<String, dynamic> json) =>
      _$LocationSearchResultFromJson(json);
}
