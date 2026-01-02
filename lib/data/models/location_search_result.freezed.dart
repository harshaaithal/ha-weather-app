// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocationSearchResult {

 int get id; String get name; double get latitude; double get longitude; String? get country;@JsonKey(name: 'country_code') String? get countryCode; String? get admin1;// State/Province
 String? get admin2;// County/District
 String? get timezone; int? get population;
/// Create a copy of LocationSearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationSearchResultCopyWith<LocationSearchResult> get copyWith => _$LocationSearchResultCopyWithImpl<LocationSearchResult>(this as LocationSearchResult, _$identity);

  /// Serializes this LocationSearchResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationSearchResult&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.country, country) || other.country == country)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.admin1, admin1) || other.admin1 == admin1)&&(identical(other.admin2, admin2) || other.admin2 == admin2)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.population, population) || other.population == population));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,latitude,longitude,country,countryCode,admin1,admin2,timezone,population);

@override
String toString() {
  return 'LocationSearchResult(id: $id, name: $name, latitude: $latitude, longitude: $longitude, country: $country, countryCode: $countryCode, admin1: $admin1, admin2: $admin2, timezone: $timezone, population: $population)';
}


}

/// @nodoc
abstract mixin class $LocationSearchResultCopyWith<$Res>  {
  factory $LocationSearchResultCopyWith(LocationSearchResult value, $Res Function(LocationSearchResult) _then) = _$LocationSearchResultCopyWithImpl;
@useResult
$Res call({
 int id, String name, double latitude, double longitude, String? country,@JsonKey(name: 'country_code') String? countryCode, String? admin1, String? admin2, String? timezone, int? population
});




}
/// @nodoc
class _$LocationSearchResultCopyWithImpl<$Res>
    implements $LocationSearchResultCopyWith<$Res> {
  _$LocationSearchResultCopyWithImpl(this._self, this._then);

  final LocationSearchResult _self;
  final $Res Function(LocationSearchResult) _then;

/// Create a copy of LocationSearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? latitude = null,Object? longitude = null,Object? country = freezed,Object? countryCode = freezed,Object? admin1 = freezed,Object? admin2 = freezed,Object? timezone = freezed,Object? population = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,admin1: freezed == admin1 ? _self.admin1 : admin1 // ignore: cast_nullable_to_non_nullable
as String?,admin2: freezed == admin2 ? _self.admin2 : admin2 // ignore: cast_nullable_to_non_nullable
as String?,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,population: freezed == population ? _self.population : population // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationSearchResult].
extension LocationSearchResultPatterns on LocationSearchResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationSearchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationSearchResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationSearchResult value)  $default,){
final _that = this;
switch (_that) {
case _LocationSearchResult():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationSearchResult value)?  $default,){
final _that = this;
switch (_that) {
case _LocationSearchResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  double latitude,  double longitude,  String? country, @JsonKey(name: 'country_code')  String? countryCode,  String? admin1,  String? admin2,  String? timezone,  int? population)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationSearchResult() when $default != null:
return $default(_that.id,_that.name,_that.latitude,_that.longitude,_that.country,_that.countryCode,_that.admin1,_that.admin2,_that.timezone,_that.population);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  double latitude,  double longitude,  String? country, @JsonKey(name: 'country_code')  String? countryCode,  String? admin1,  String? admin2,  String? timezone,  int? population)  $default,) {final _that = this;
switch (_that) {
case _LocationSearchResult():
return $default(_that.id,_that.name,_that.latitude,_that.longitude,_that.country,_that.countryCode,_that.admin1,_that.admin2,_that.timezone,_that.population);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  double latitude,  double longitude,  String? country, @JsonKey(name: 'country_code')  String? countryCode,  String? admin1,  String? admin2,  String? timezone,  int? population)?  $default,) {final _that = this;
switch (_that) {
case _LocationSearchResult() when $default != null:
return $default(_that.id,_that.name,_that.latitude,_that.longitude,_that.country,_that.countryCode,_that.admin1,_that.admin2,_that.timezone,_that.population);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocationSearchResult implements LocationSearchResult {
  const _LocationSearchResult({required this.id, required this.name, required this.latitude, required this.longitude, this.country, @JsonKey(name: 'country_code') this.countryCode, this.admin1, this.admin2, this.timezone, this.population});
  factory _LocationSearchResult.fromJson(Map<String, dynamic> json) => _$LocationSearchResultFromJson(json);

@override final  int id;
@override final  String name;
@override final  double latitude;
@override final  double longitude;
@override final  String? country;
@override@JsonKey(name: 'country_code') final  String? countryCode;
@override final  String? admin1;
// State/Province
@override final  String? admin2;
// County/District
@override final  String? timezone;
@override final  int? population;

/// Create a copy of LocationSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationSearchResultCopyWith<_LocationSearchResult> get copyWith => __$LocationSearchResultCopyWithImpl<_LocationSearchResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationSearchResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationSearchResult&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.country, country) || other.country == country)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.admin1, admin1) || other.admin1 == admin1)&&(identical(other.admin2, admin2) || other.admin2 == admin2)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.population, population) || other.population == population));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,latitude,longitude,country,countryCode,admin1,admin2,timezone,population);

@override
String toString() {
  return 'LocationSearchResult(id: $id, name: $name, latitude: $latitude, longitude: $longitude, country: $country, countryCode: $countryCode, admin1: $admin1, admin2: $admin2, timezone: $timezone, population: $population)';
}


}

/// @nodoc
abstract mixin class _$LocationSearchResultCopyWith<$Res> implements $LocationSearchResultCopyWith<$Res> {
  factory _$LocationSearchResultCopyWith(_LocationSearchResult value, $Res Function(_LocationSearchResult) _then) = __$LocationSearchResultCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, double latitude, double longitude, String? country,@JsonKey(name: 'country_code') String? countryCode, String? admin1, String? admin2, String? timezone, int? population
});




}
/// @nodoc
class __$LocationSearchResultCopyWithImpl<$Res>
    implements _$LocationSearchResultCopyWith<$Res> {
  __$LocationSearchResultCopyWithImpl(this._self, this._then);

  final _LocationSearchResult _self;
  final $Res Function(_LocationSearchResult) _then;

/// Create a copy of LocationSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? latitude = null,Object? longitude = null,Object? country = freezed,Object? countryCode = freezed,Object? admin1 = freezed,Object? admin2 = freezed,Object? timezone = freezed,Object? population = freezed,}) {
  return _then(_LocationSearchResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,admin1: freezed == admin1 ? _self.admin1 : admin1 // ignore: cast_nullable_to_non_nullable
as String?,admin2: freezed == admin2 ? _self.admin2 : admin2 // ignore: cast_nullable_to_non_nullable
as String?,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,population: freezed == population ? _self.population : population // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
