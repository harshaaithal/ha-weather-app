// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Weather {

 CurrentWeather get current; List<HourlyWeather> get hourly; List<DailyWeather> get daily; Location get location;
/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherCopyWith<Weather> get copyWith => _$WeatherCopyWithImpl<Weather>(this as Weather, _$identity);

  /// Serializes this Weather to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Weather&&(identical(other.current, current) || other.current == current)&&const DeepCollectionEquality().equals(other.hourly, hourly)&&const DeepCollectionEquality().equals(other.daily, daily)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,current,const DeepCollectionEquality().hash(hourly),const DeepCollectionEquality().hash(daily),location);

@override
String toString() {
  return 'Weather(current: $current, hourly: $hourly, daily: $daily, location: $location)';
}


}

/// @nodoc
abstract mixin class $WeatherCopyWith<$Res>  {
  factory $WeatherCopyWith(Weather value, $Res Function(Weather) _then) = _$WeatherCopyWithImpl;
@useResult
$Res call({
 CurrentWeather current, List<HourlyWeather> hourly, List<DailyWeather> daily, Location location
});


$CurrentWeatherCopyWith<$Res> get current;$LocationCopyWith<$Res> get location;

}
/// @nodoc
class _$WeatherCopyWithImpl<$Res>
    implements $WeatherCopyWith<$Res> {
  _$WeatherCopyWithImpl(this._self, this._then);

  final Weather _self;
  final $Res Function(Weather) _then;

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? current = null,Object? hourly = null,Object? daily = null,Object? location = null,}) {
  return _then(_self.copyWith(
current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as CurrentWeather,hourly: null == hourly ? _self.hourly : hourly // ignore: cast_nullable_to_non_nullable
as List<HourlyWeather>,daily: null == daily ? _self.daily : daily // ignore: cast_nullable_to_non_nullable
as List<DailyWeather>,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Location,
  ));
}
/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentWeatherCopyWith<$Res> get current {
  
  return $CurrentWeatherCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationCopyWith<$Res> get location {
  
  return $LocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [Weather].
extension WeatherPatterns on Weather {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Weather value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Weather() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Weather value)  $default,){
final _that = this;
switch (_that) {
case _Weather():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Weather value)?  $default,){
final _that = this;
switch (_that) {
case _Weather() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CurrentWeather current,  List<HourlyWeather> hourly,  List<DailyWeather> daily,  Location location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Weather() when $default != null:
return $default(_that.current,_that.hourly,_that.daily,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CurrentWeather current,  List<HourlyWeather> hourly,  List<DailyWeather> daily,  Location location)  $default,) {final _that = this;
switch (_that) {
case _Weather():
return $default(_that.current,_that.hourly,_that.daily,_that.location);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CurrentWeather current,  List<HourlyWeather> hourly,  List<DailyWeather> daily,  Location location)?  $default,) {final _that = this;
switch (_that) {
case _Weather() when $default != null:
return $default(_that.current,_that.hourly,_that.daily,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Weather extends Weather {
  const _Weather({required this.current, required final  List<HourlyWeather> hourly, required final  List<DailyWeather> daily, required this.location}): _hourly = hourly,_daily = daily,super._();
  factory _Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

@override final  CurrentWeather current;
 final  List<HourlyWeather> _hourly;
@override List<HourlyWeather> get hourly {
  if (_hourly is EqualUnmodifiableListView) return _hourly;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hourly);
}

 final  List<DailyWeather> _daily;
@override List<DailyWeather> get daily {
  if (_daily is EqualUnmodifiableListView) return _daily;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_daily);
}

@override final  Location location;

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherCopyWith<_Weather> get copyWith => __$WeatherCopyWithImpl<_Weather>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Weather&&(identical(other.current, current) || other.current == current)&&const DeepCollectionEquality().equals(other._hourly, _hourly)&&const DeepCollectionEquality().equals(other._daily, _daily)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,current,const DeepCollectionEquality().hash(_hourly),const DeepCollectionEquality().hash(_daily),location);

@override
String toString() {
  return 'Weather(current: $current, hourly: $hourly, daily: $daily, location: $location)';
}


}

/// @nodoc
abstract mixin class _$WeatherCopyWith<$Res> implements $WeatherCopyWith<$Res> {
  factory _$WeatherCopyWith(_Weather value, $Res Function(_Weather) _then) = __$WeatherCopyWithImpl;
@override @useResult
$Res call({
 CurrentWeather current, List<HourlyWeather> hourly, List<DailyWeather> daily, Location location
});


@override $CurrentWeatherCopyWith<$Res> get current;@override $LocationCopyWith<$Res> get location;

}
/// @nodoc
class __$WeatherCopyWithImpl<$Res>
    implements _$WeatherCopyWith<$Res> {
  __$WeatherCopyWithImpl(this._self, this._then);

  final _Weather _self;
  final $Res Function(_Weather) _then;

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? current = null,Object? hourly = null,Object? daily = null,Object? location = null,}) {
  return _then(_Weather(
current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as CurrentWeather,hourly: null == hourly ? _self._hourly : hourly // ignore: cast_nullable_to_non_nullable
as List<HourlyWeather>,daily: null == daily ? _self._daily : daily // ignore: cast_nullable_to_non_nullable
as List<DailyWeather>,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Location,
  ));
}

/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentWeatherCopyWith<$Res> get current {
  
  return $CurrentWeatherCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of Weather
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationCopyWith<$Res> get location {
  
  return $LocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc
mixin _$CurrentWeather {

 double get temperature; double get apparentTemperature; int get humidity; int get weatherCode; double get windSpeed; int get windDirection; double get windGusts; double get precipitation; int get cloudCover; bool get isDay; DateTime get time;
/// Create a copy of CurrentWeather
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentWeatherCopyWith<CurrentWeather> get copyWith => _$CurrentWeatherCopyWithImpl<CurrentWeather>(this as CurrentWeather, _$identity);

  /// Serializes this CurrentWeather to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentWeather&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.apparentTemperature, apparentTemperature) || other.apparentTemperature == apparentTemperature)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.windDirection, windDirection) || other.windDirection == windDirection)&&(identical(other.windGusts, windGusts) || other.windGusts == windGusts)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.cloudCover, cloudCover) || other.cloudCover == cloudCover)&&(identical(other.isDay, isDay) || other.isDay == isDay)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,temperature,apparentTemperature,humidity,weatherCode,windSpeed,windDirection,windGusts,precipitation,cloudCover,isDay,time);

@override
String toString() {
  return 'CurrentWeather(temperature: $temperature, apparentTemperature: $apparentTemperature, humidity: $humidity, weatherCode: $weatherCode, windSpeed: $windSpeed, windDirection: $windDirection, windGusts: $windGusts, precipitation: $precipitation, cloudCover: $cloudCover, isDay: $isDay, time: $time)';
}


}

/// @nodoc
abstract mixin class $CurrentWeatherCopyWith<$Res>  {
  factory $CurrentWeatherCopyWith(CurrentWeather value, $Res Function(CurrentWeather) _then) = _$CurrentWeatherCopyWithImpl;
@useResult
$Res call({
 double temperature, double apparentTemperature, int humidity, int weatherCode, double windSpeed, int windDirection, double windGusts, double precipitation, int cloudCover, bool isDay, DateTime time
});




}
/// @nodoc
class _$CurrentWeatherCopyWithImpl<$Res>
    implements $CurrentWeatherCopyWith<$Res> {
  _$CurrentWeatherCopyWithImpl(this._self, this._then);

  final CurrentWeather _self;
  final $Res Function(CurrentWeather) _then;

/// Create a copy of CurrentWeather
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? temperature = null,Object? apparentTemperature = null,Object? humidity = null,Object? weatherCode = null,Object? windSpeed = null,Object? windDirection = null,Object? windGusts = null,Object? precipitation = null,Object? cloudCover = null,Object? isDay = null,Object? time = null,}) {
  return _then(_self.copyWith(
temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,apparentTemperature: null == apparentTemperature ? _self.apparentTemperature : apparentTemperature // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,weatherCode: null == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int,windSpeed: null == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double,windDirection: null == windDirection ? _self.windDirection : windDirection // ignore: cast_nullable_to_non_nullable
as int,windGusts: null == windGusts ? _self.windGusts : windGusts // ignore: cast_nullable_to_non_nullable
as double,precipitation: null == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double,cloudCover: null == cloudCover ? _self.cloudCover : cloudCover // ignore: cast_nullable_to_non_nullable
as int,isDay: null == isDay ? _self.isDay : isDay // ignore: cast_nullable_to_non_nullable
as bool,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentWeather].
extension CurrentWeatherPatterns on CurrentWeather {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentWeather value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentWeather() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentWeather value)  $default,){
final _that = this;
switch (_that) {
case _CurrentWeather():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentWeather value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentWeather() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double temperature,  double apparentTemperature,  int humidity,  int weatherCode,  double windSpeed,  int windDirection,  double windGusts,  double precipitation,  int cloudCover,  bool isDay,  DateTime time)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentWeather() when $default != null:
return $default(_that.temperature,_that.apparentTemperature,_that.humidity,_that.weatherCode,_that.windSpeed,_that.windDirection,_that.windGusts,_that.precipitation,_that.cloudCover,_that.isDay,_that.time);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double temperature,  double apparentTemperature,  int humidity,  int weatherCode,  double windSpeed,  int windDirection,  double windGusts,  double precipitation,  int cloudCover,  bool isDay,  DateTime time)  $default,) {final _that = this;
switch (_that) {
case _CurrentWeather():
return $default(_that.temperature,_that.apparentTemperature,_that.humidity,_that.weatherCode,_that.windSpeed,_that.windDirection,_that.windGusts,_that.precipitation,_that.cloudCover,_that.isDay,_that.time);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double temperature,  double apparentTemperature,  int humidity,  int weatherCode,  double windSpeed,  int windDirection,  double windGusts,  double precipitation,  int cloudCover,  bool isDay,  DateTime time)?  $default,) {final _that = this;
switch (_that) {
case _CurrentWeather() when $default != null:
return $default(_that.temperature,_that.apparentTemperature,_that.humidity,_that.weatherCode,_that.windSpeed,_that.windDirection,_that.windGusts,_that.precipitation,_that.cloudCover,_that.isDay,_that.time);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrentWeather extends CurrentWeather {
  const _CurrentWeather({required this.temperature, required this.apparentTemperature, required this.humidity, required this.weatherCode, required this.windSpeed, required this.windDirection, required this.windGusts, required this.precipitation, required this.cloudCover, required this.isDay, required this.time}): super._();
  factory _CurrentWeather.fromJson(Map<String, dynamic> json) => _$CurrentWeatherFromJson(json);

@override final  double temperature;
@override final  double apparentTemperature;
@override final  int humidity;
@override final  int weatherCode;
@override final  double windSpeed;
@override final  int windDirection;
@override final  double windGusts;
@override final  double precipitation;
@override final  int cloudCover;
@override final  bool isDay;
@override final  DateTime time;

/// Create a copy of CurrentWeather
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentWeatherCopyWith<_CurrentWeather> get copyWith => __$CurrentWeatherCopyWithImpl<_CurrentWeather>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentWeatherToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentWeather&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.apparentTemperature, apparentTemperature) || other.apparentTemperature == apparentTemperature)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.windDirection, windDirection) || other.windDirection == windDirection)&&(identical(other.windGusts, windGusts) || other.windGusts == windGusts)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.cloudCover, cloudCover) || other.cloudCover == cloudCover)&&(identical(other.isDay, isDay) || other.isDay == isDay)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,temperature,apparentTemperature,humidity,weatherCode,windSpeed,windDirection,windGusts,precipitation,cloudCover,isDay,time);

@override
String toString() {
  return 'CurrentWeather(temperature: $temperature, apparentTemperature: $apparentTemperature, humidity: $humidity, weatherCode: $weatherCode, windSpeed: $windSpeed, windDirection: $windDirection, windGusts: $windGusts, precipitation: $precipitation, cloudCover: $cloudCover, isDay: $isDay, time: $time)';
}


}

/// @nodoc
abstract mixin class _$CurrentWeatherCopyWith<$Res> implements $CurrentWeatherCopyWith<$Res> {
  factory _$CurrentWeatherCopyWith(_CurrentWeather value, $Res Function(_CurrentWeather) _then) = __$CurrentWeatherCopyWithImpl;
@override @useResult
$Res call({
 double temperature, double apparentTemperature, int humidity, int weatherCode, double windSpeed, int windDirection, double windGusts, double precipitation, int cloudCover, bool isDay, DateTime time
});




}
/// @nodoc
class __$CurrentWeatherCopyWithImpl<$Res>
    implements _$CurrentWeatherCopyWith<$Res> {
  __$CurrentWeatherCopyWithImpl(this._self, this._then);

  final _CurrentWeather _self;
  final $Res Function(_CurrentWeather) _then;

/// Create a copy of CurrentWeather
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? temperature = null,Object? apparentTemperature = null,Object? humidity = null,Object? weatherCode = null,Object? windSpeed = null,Object? windDirection = null,Object? windGusts = null,Object? precipitation = null,Object? cloudCover = null,Object? isDay = null,Object? time = null,}) {
  return _then(_CurrentWeather(
temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,apparentTemperature: null == apparentTemperature ? _self.apparentTemperature : apparentTemperature // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,weatherCode: null == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int,windSpeed: null == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double,windDirection: null == windDirection ? _self.windDirection : windDirection // ignore: cast_nullable_to_non_nullable
as int,windGusts: null == windGusts ? _self.windGusts : windGusts // ignore: cast_nullable_to_non_nullable
as double,precipitation: null == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double,cloudCover: null == cloudCover ? _self.cloudCover : cloudCover // ignore: cast_nullable_to_non_nullable
as int,isDay: null == isDay ? _self.isDay : isDay // ignore: cast_nullable_to_non_nullable
as bool,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$HourlyWeather {

 DateTime get time; double get temperature; double get apparentTemperature; int get humidity; int get weatherCode; double get windSpeed; int get precipitationProbability; double get precipitation; bool get isDay;
/// Create a copy of HourlyWeather
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HourlyWeatherCopyWith<HourlyWeather> get copyWith => _$HourlyWeatherCopyWithImpl<HourlyWeather>(this as HourlyWeather, _$identity);

  /// Serializes this HourlyWeather to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HourlyWeather&&(identical(other.time, time) || other.time == time)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.apparentTemperature, apparentTemperature) || other.apparentTemperature == apparentTemperature)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.precipitationProbability, precipitationProbability) || other.precipitationProbability == precipitationProbability)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.isDay, isDay) || other.isDay == isDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,temperature,apparentTemperature,humidity,weatherCode,windSpeed,precipitationProbability,precipitation,isDay);

@override
String toString() {
  return 'HourlyWeather(time: $time, temperature: $temperature, apparentTemperature: $apparentTemperature, humidity: $humidity, weatherCode: $weatherCode, windSpeed: $windSpeed, precipitationProbability: $precipitationProbability, precipitation: $precipitation, isDay: $isDay)';
}


}

/// @nodoc
abstract mixin class $HourlyWeatherCopyWith<$Res>  {
  factory $HourlyWeatherCopyWith(HourlyWeather value, $Res Function(HourlyWeather) _then) = _$HourlyWeatherCopyWithImpl;
@useResult
$Res call({
 DateTime time, double temperature, double apparentTemperature, int humidity, int weatherCode, double windSpeed, int precipitationProbability, double precipitation, bool isDay
});




}
/// @nodoc
class _$HourlyWeatherCopyWithImpl<$Res>
    implements $HourlyWeatherCopyWith<$Res> {
  _$HourlyWeatherCopyWithImpl(this._self, this._then);

  final HourlyWeather _self;
  final $Res Function(HourlyWeather) _then;

/// Create a copy of HourlyWeather
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? temperature = null,Object? apparentTemperature = null,Object? humidity = null,Object? weatherCode = null,Object? windSpeed = null,Object? precipitationProbability = null,Object? precipitation = null,Object? isDay = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,apparentTemperature: null == apparentTemperature ? _self.apparentTemperature : apparentTemperature // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,weatherCode: null == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int,windSpeed: null == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double,precipitationProbability: null == precipitationProbability ? _self.precipitationProbability : precipitationProbability // ignore: cast_nullable_to_non_nullable
as int,precipitation: null == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double,isDay: null == isDay ? _self.isDay : isDay // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HourlyWeather].
extension HourlyWeatherPatterns on HourlyWeather {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HourlyWeather value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HourlyWeather() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HourlyWeather value)  $default,){
final _that = this;
switch (_that) {
case _HourlyWeather():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HourlyWeather value)?  $default,){
final _that = this;
switch (_that) {
case _HourlyWeather() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime time,  double temperature,  double apparentTemperature,  int humidity,  int weatherCode,  double windSpeed,  int precipitationProbability,  double precipitation,  bool isDay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HourlyWeather() when $default != null:
return $default(_that.time,_that.temperature,_that.apparentTemperature,_that.humidity,_that.weatherCode,_that.windSpeed,_that.precipitationProbability,_that.precipitation,_that.isDay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime time,  double temperature,  double apparentTemperature,  int humidity,  int weatherCode,  double windSpeed,  int precipitationProbability,  double precipitation,  bool isDay)  $default,) {final _that = this;
switch (_that) {
case _HourlyWeather():
return $default(_that.time,_that.temperature,_that.apparentTemperature,_that.humidity,_that.weatherCode,_that.windSpeed,_that.precipitationProbability,_that.precipitation,_that.isDay);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime time,  double temperature,  double apparentTemperature,  int humidity,  int weatherCode,  double windSpeed,  int precipitationProbability,  double precipitation,  bool isDay)?  $default,) {final _that = this;
switch (_that) {
case _HourlyWeather() when $default != null:
return $default(_that.time,_that.temperature,_that.apparentTemperature,_that.humidity,_that.weatherCode,_that.windSpeed,_that.precipitationProbability,_that.precipitation,_that.isDay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HourlyWeather extends HourlyWeather {
  const _HourlyWeather({required this.time, required this.temperature, required this.apparentTemperature, required this.humidity, required this.weatherCode, required this.windSpeed, required this.precipitationProbability, required this.precipitation, required this.isDay}): super._();
  factory _HourlyWeather.fromJson(Map<String, dynamic> json) => _$HourlyWeatherFromJson(json);

@override final  DateTime time;
@override final  double temperature;
@override final  double apparentTemperature;
@override final  int humidity;
@override final  int weatherCode;
@override final  double windSpeed;
@override final  int precipitationProbability;
@override final  double precipitation;
@override final  bool isDay;

/// Create a copy of HourlyWeather
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HourlyWeatherCopyWith<_HourlyWeather> get copyWith => __$HourlyWeatherCopyWithImpl<_HourlyWeather>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HourlyWeatherToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HourlyWeather&&(identical(other.time, time) || other.time == time)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.apparentTemperature, apparentTemperature) || other.apparentTemperature == apparentTemperature)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.precipitationProbability, precipitationProbability) || other.precipitationProbability == precipitationProbability)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.isDay, isDay) || other.isDay == isDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,temperature,apparentTemperature,humidity,weatherCode,windSpeed,precipitationProbability,precipitation,isDay);

@override
String toString() {
  return 'HourlyWeather(time: $time, temperature: $temperature, apparentTemperature: $apparentTemperature, humidity: $humidity, weatherCode: $weatherCode, windSpeed: $windSpeed, precipitationProbability: $precipitationProbability, precipitation: $precipitation, isDay: $isDay)';
}


}

/// @nodoc
abstract mixin class _$HourlyWeatherCopyWith<$Res> implements $HourlyWeatherCopyWith<$Res> {
  factory _$HourlyWeatherCopyWith(_HourlyWeather value, $Res Function(_HourlyWeather) _then) = __$HourlyWeatherCopyWithImpl;
@override @useResult
$Res call({
 DateTime time, double temperature, double apparentTemperature, int humidity, int weatherCode, double windSpeed, int precipitationProbability, double precipitation, bool isDay
});




}
/// @nodoc
class __$HourlyWeatherCopyWithImpl<$Res>
    implements _$HourlyWeatherCopyWith<$Res> {
  __$HourlyWeatherCopyWithImpl(this._self, this._then);

  final _HourlyWeather _self;
  final $Res Function(_HourlyWeather) _then;

/// Create a copy of HourlyWeather
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? temperature = null,Object? apparentTemperature = null,Object? humidity = null,Object? weatherCode = null,Object? windSpeed = null,Object? precipitationProbability = null,Object? precipitation = null,Object? isDay = null,}) {
  return _then(_HourlyWeather(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,apparentTemperature: null == apparentTemperature ? _self.apparentTemperature : apparentTemperature // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,weatherCode: null == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int,windSpeed: null == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double,precipitationProbability: null == precipitationProbability ? _self.precipitationProbability : precipitationProbability // ignore: cast_nullable_to_non_nullable
as int,precipitation: null == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double,isDay: null == isDay ? _self.isDay : isDay // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$DailyWeather {

 DateTime get date; int get weatherCode; double get temperatureMax; double get temperatureMin; double get apparentTemperatureMax; double get apparentTemperatureMin; DateTime get sunrise; DateTime get sunset; double get precipitationSum; int get precipitationProbabilityMax; double get windSpeedMax;
/// Create a copy of DailyWeather
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyWeatherCopyWith<DailyWeather> get copyWith => _$DailyWeatherCopyWithImpl<DailyWeather>(this as DailyWeather, _$identity);

  /// Serializes this DailyWeather to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyWeather&&(identical(other.date, date) || other.date == date)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.temperatureMax, temperatureMax) || other.temperatureMax == temperatureMax)&&(identical(other.temperatureMin, temperatureMin) || other.temperatureMin == temperatureMin)&&(identical(other.apparentTemperatureMax, apparentTemperatureMax) || other.apparentTemperatureMax == apparentTemperatureMax)&&(identical(other.apparentTemperatureMin, apparentTemperatureMin) || other.apparentTemperatureMin == apparentTemperatureMin)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset)&&(identical(other.precipitationSum, precipitationSum) || other.precipitationSum == precipitationSum)&&(identical(other.precipitationProbabilityMax, precipitationProbabilityMax) || other.precipitationProbabilityMax == precipitationProbabilityMax)&&(identical(other.windSpeedMax, windSpeedMax) || other.windSpeedMax == windSpeedMax));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,weatherCode,temperatureMax,temperatureMin,apparentTemperatureMax,apparentTemperatureMin,sunrise,sunset,precipitationSum,precipitationProbabilityMax,windSpeedMax);

@override
String toString() {
  return 'DailyWeather(date: $date, weatherCode: $weatherCode, temperatureMax: $temperatureMax, temperatureMin: $temperatureMin, apparentTemperatureMax: $apparentTemperatureMax, apparentTemperatureMin: $apparentTemperatureMin, sunrise: $sunrise, sunset: $sunset, precipitationSum: $precipitationSum, precipitationProbabilityMax: $precipitationProbabilityMax, windSpeedMax: $windSpeedMax)';
}


}

/// @nodoc
abstract mixin class $DailyWeatherCopyWith<$Res>  {
  factory $DailyWeatherCopyWith(DailyWeather value, $Res Function(DailyWeather) _then) = _$DailyWeatherCopyWithImpl;
@useResult
$Res call({
 DateTime date, int weatherCode, double temperatureMax, double temperatureMin, double apparentTemperatureMax, double apparentTemperatureMin, DateTime sunrise, DateTime sunset, double precipitationSum, int precipitationProbabilityMax, double windSpeedMax
});




}
/// @nodoc
class _$DailyWeatherCopyWithImpl<$Res>
    implements $DailyWeatherCopyWith<$Res> {
  _$DailyWeatherCopyWithImpl(this._self, this._then);

  final DailyWeather _self;
  final $Res Function(DailyWeather) _then;

/// Create a copy of DailyWeather
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? weatherCode = null,Object? temperatureMax = null,Object? temperatureMin = null,Object? apparentTemperatureMax = null,Object? apparentTemperatureMin = null,Object? sunrise = null,Object? sunset = null,Object? precipitationSum = null,Object? precipitationProbabilityMax = null,Object? windSpeedMax = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,weatherCode: null == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int,temperatureMax: null == temperatureMax ? _self.temperatureMax : temperatureMax // ignore: cast_nullable_to_non_nullable
as double,temperatureMin: null == temperatureMin ? _self.temperatureMin : temperatureMin // ignore: cast_nullable_to_non_nullable
as double,apparentTemperatureMax: null == apparentTemperatureMax ? _self.apparentTemperatureMax : apparentTemperatureMax // ignore: cast_nullable_to_non_nullable
as double,apparentTemperatureMin: null == apparentTemperatureMin ? _self.apparentTemperatureMin : apparentTemperatureMin // ignore: cast_nullable_to_non_nullable
as double,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,sunset: null == sunset ? _self.sunset : sunset // ignore: cast_nullable_to_non_nullable
as DateTime,precipitationSum: null == precipitationSum ? _self.precipitationSum : precipitationSum // ignore: cast_nullable_to_non_nullable
as double,precipitationProbabilityMax: null == precipitationProbabilityMax ? _self.precipitationProbabilityMax : precipitationProbabilityMax // ignore: cast_nullable_to_non_nullable
as int,windSpeedMax: null == windSpeedMax ? _self.windSpeedMax : windSpeedMax // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyWeather].
extension DailyWeatherPatterns on DailyWeather {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyWeather value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyWeather() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyWeather value)  $default,){
final _that = this;
switch (_that) {
case _DailyWeather():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyWeather value)?  $default,){
final _that = this;
switch (_that) {
case _DailyWeather() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int weatherCode,  double temperatureMax,  double temperatureMin,  double apparentTemperatureMax,  double apparentTemperatureMin,  DateTime sunrise,  DateTime sunset,  double precipitationSum,  int precipitationProbabilityMax,  double windSpeedMax)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyWeather() when $default != null:
return $default(_that.date,_that.weatherCode,_that.temperatureMax,_that.temperatureMin,_that.apparentTemperatureMax,_that.apparentTemperatureMin,_that.sunrise,_that.sunset,_that.precipitationSum,_that.precipitationProbabilityMax,_that.windSpeedMax);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int weatherCode,  double temperatureMax,  double temperatureMin,  double apparentTemperatureMax,  double apparentTemperatureMin,  DateTime sunrise,  DateTime sunset,  double precipitationSum,  int precipitationProbabilityMax,  double windSpeedMax)  $default,) {final _that = this;
switch (_that) {
case _DailyWeather():
return $default(_that.date,_that.weatherCode,_that.temperatureMax,_that.temperatureMin,_that.apparentTemperatureMax,_that.apparentTemperatureMin,_that.sunrise,_that.sunset,_that.precipitationSum,_that.precipitationProbabilityMax,_that.windSpeedMax);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int weatherCode,  double temperatureMax,  double temperatureMin,  double apparentTemperatureMax,  double apparentTemperatureMin,  DateTime sunrise,  DateTime sunset,  double precipitationSum,  int precipitationProbabilityMax,  double windSpeedMax)?  $default,) {final _that = this;
switch (_that) {
case _DailyWeather() when $default != null:
return $default(_that.date,_that.weatherCode,_that.temperatureMax,_that.temperatureMin,_that.apparentTemperatureMax,_that.apparentTemperatureMin,_that.sunrise,_that.sunset,_that.precipitationSum,_that.precipitationProbabilityMax,_that.windSpeedMax);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyWeather extends DailyWeather {
  const _DailyWeather({required this.date, required this.weatherCode, required this.temperatureMax, required this.temperatureMin, required this.apparentTemperatureMax, required this.apparentTemperatureMin, required this.sunrise, required this.sunset, required this.precipitationSum, required this.precipitationProbabilityMax, required this.windSpeedMax}): super._();
  factory _DailyWeather.fromJson(Map<String, dynamic> json) => _$DailyWeatherFromJson(json);

@override final  DateTime date;
@override final  int weatherCode;
@override final  double temperatureMax;
@override final  double temperatureMin;
@override final  double apparentTemperatureMax;
@override final  double apparentTemperatureMin;
@override final  DateTime sunrise;
@override final  DateTime sunset;
@override final  double precipitationSum;
@override final  int precipitationProbabilityMax;
@override final  double windSpeedMax;

/// Create a copy of DailyWeather
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyWeatherCopyWith<_DailyWeather> get copyWith => __$DailyWeatherCopyWithImpl<_DailyWeather>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyWeatherToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyWeather&&(identical(other.date, date) || other.date == date)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.temperatureMax, temperatureMax) || other.temperatureMax == temperatureMax)&&(identical(other.temperatureMin, temperatureMin) || other.temperatureMin == temperatureMin)&&(identical(other.apparentTemperatureMax, apparentTemperatureMax) || other.apparentTemperatureMax == apparentTemperatureMax)&&(identical(other.apparentTemperatureMin, apparentTemperatureMin) || other.apparentTemperatureMin == apparentTemperatureMin)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset)&&(identical(other.precipitationSum, precipitationSum) || other.precipitationSum == precipitationSum)&&(identical(other.precipitationProbabilityMax, precipitationProbabilityMax) || other.precipitationProbabilityMax == precipitationProbabilityMax)&&(identical(other.windSpeedMax, windSpeedMax) || other.windSpeedMax == windSpeedMax));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,weatherCode,temperatureMax,temperatureMin,apparentTemperatureMax,apparentTemperatureMin,sunrise,sunset,precipitationSum,precipitationProbabilityMax,windSpeedMax);

@override
String toString() {
  return 'DailyWeather(date: $date, weatherCode: $weatherCode, temperatureMax: $temperatureMax, temperatureMin: $temperatureMin, apparentTemperatureMax: $apparentTemperatureMax, apparentTemperatureMin: $apparentTemperatureMin, sunrise: $sunrise, sunset: $sunset, precipitationSum: $precipitationSum, precipitationProbabilityMax: $precipitationProbabilityMax, windSpeedMax: $windSpeedMax)';
}


}

/// @nodoc
abstract mixin class _$DailyWeatherCopyWith<$Res> implements $DailyWeatherCopyWith<$Res> {
  factory _$DailyWeatherCopyWith(_DailyWeather value, $Res Function(_DailyWeather) _then) = __$DailyWeatherCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int weatherCode, double temperatureMax, double temperatureMin, double apparentTemperatureMax, double apparentTemperatureMin, DateTime sunrise, DateTime sunset, double precipitationSum, int precipitationProbabilityMax, double windSpeedMax
});




}
/// @nodoc
class __$DailyWeatherCopyWithImpl<$Res>
    implements _$DailyWeatherCopyWith<$Res> {
  __$DailyWeatherCopyWithImpl(this._self, this._then);

  final _DailyWeather _self;
  final $Res Function(_DailyWeather) _then;

/// Create a copy of DailyWeather
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? weatherCode = null,Object? temperatureMax = null,Object? temperatureMin = null,Object? apparentTemperatureMax = null,Object? apparentTemperatureMin = null,Object? sunrise = null,Object? sunset = null,Object? precipitationSum = null,Object? precipitationProbabilityMax = null,Object? windSpeedMax = null,}) {
  return _then(_DailyWeather(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,weatherCode: null == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int,temperatureMax: null == temperatureMax ? _self.temperatureMax : temperatureMax // ignore: cast_nullable_to_non_nullable
as double,temperatureMin: null == temperatureMin ? _self.temperatureMin : temperatureMin // ignore: cast_nullable_to_non_nullable
as double,apparentTemperatureMax: null == apparentTemperatureMax ? _self.apparentTemperatureMax : apparentTemperatureMax // ignore: cast_nullable_to_non_nullable
as double,apparentTemperatureMin: null == apparentTemperatureMin ? _self.apparentTemperatureMin : apparentTemperatureMin // ignore: cast_nullable_to_non_nullable
as double,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,sunset: null == sunset ? _self.sunset : sunset // ignore: cast_nullable_to_non_nullable
as DateTime,precipitationSum: null == precipitationSum ? _self.precipitationSum : precipitationSum // ignore: cast_nullable_to_non_nullable
as double,precipitationProbabilityMax: null == precipitationProbabilityMax ? _self.precipitationProbabilityMax : precipitationProbabilityMax // ignore: cast_nullable_to_non_nullable
as int,windSpeedMax: null == windSpeedMax ? _self.windSpeedMax : windSpeedMax // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Location {

 double get latitude; double get longitude; String get name; String? get country; String? get admin1;// State/Province
 String? get timezone;
/// Create a copy of Location
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationCopyWith<Location> get copyWith => _$LocationCopyWithImpl<Location>(this as Location, _$identity);

  /// Serializes this Location to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Location&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.admin1, admin1) || other.admin1 == admin1)&&(identical(other.timezone, timezone) || other.timezone == timezone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,name,country,admin1,timezone);

@override
String toString() {
  return 'Location(latitude: $latitude, longitude: $longitude, name: $name, country: $country, admin1: $admin1, timezone: $timezone)';
}


}

/// @nodoc
abstract mixin class $LocationCopyWith<$Res>  {
  factory $LocationCopyWith(Location value, $Res Function(Location) _then) = _$LocationCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, String name, String? country, String? admin1, String? timezone
});




}
/// @nodoc
class _$LocationCopyWithImpl<$Res>
    implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._self, this._then);

  final Location _self;
  final $Res Function(Location) _then;

/// Create a copy of Location
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? name = null,Object? country = freezed,Object? admin1 = freezed,Object? timezone = freezed,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,admin1: freezed == admin1 ? _self.admin1 : admin1 // ignore: cast_nullable_to_non_nullable
as String?,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Location].
extension LocationPatterns on Location {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Location value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Location() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Location value)  $default,){
final _that = this;
switch (_that) {
case _Location():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Location value)?  $default,){
final _that = this;
switch (_that) {
case _Location() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  String name,  String? country,  String? admin1,  String? timezone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Location() when $default != null:
return $default(_that.latitude,_that.longitude,_that.name,_that.country,_that.admin1,_that.timezone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  String name,  String? country,  String? admin1,  String? timezone)  $default,) {final _that = this;
switch (_that) {
case _Location():
return $default(_that.latitude,_that.longitude,_that.name,_that.country,_that.admin1,_that.timezone);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  String name,  String? country,  String? admin1,  String? timezone)?  $default,) {final _that = this;
switch (_that) {
case _Location() when $default != null:
return $default(_that.latitude,_that.longitude,_that.name,_that.country,_that.admin1,_that.timezone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Location implements Location {
  const _Location({required this.latitude, required this.longitude, required this.name, this.country, this.admin1, this.timezone});
  factory _Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

@override final  double latitude;
@override final  double longitude;
@override final  String name;
@override final  String? country;
@override final  String? admin1;
// State/Province
@override final  String? timezone;

/// Create a copy of Location
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationCopyWith<_Location> get copyWith => __$LocationCopyWithImpl<_Location>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Location&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.name, name) || other.name == name)&&(identical(other.country, country) || other.country == country)&&(identical(other.admin1, admin1) || other.admin1 == admin1)&&(identical(other.timezone, timezone) || other.timezone == timezone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,name,country,admin1,timezone);

@override
String toString() {
  return 'Location(latitude: $latitude, longitude: $longitude, name: $name, country: $country, admin1: $admin1, timezone: $timezone)';
}


}

/// @nodoc
abstract mixin class _$LocationCopyWith<$Res> implements $LocationCopyWith<$Res> {
  factory _$LocationCopyWith(_Location value, $Res Function(_Location) _then) = __$LocationCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, String name, String? country, String? admin1, String? timezone
});




}
/// @nodoc
class __$LocationCopyWithImpl<$Res>
    implements _$LocationCopyWith<$Res> {
  __$LocationCopyWithImpl(this._self, this._then);

  final _Location _self;
  final $Res Function(_Location) _then;

/// Create a copy of Location
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? name = null,Object? country = freezed,Object? admin1 = freezed,Object? timezone = freezed,}) {
  return _then(_Location(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,admin1: freezed == admin1 ? _self.admin1 : admin1 // ignore: cast_nullable_to_non_nullable
as String?,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
