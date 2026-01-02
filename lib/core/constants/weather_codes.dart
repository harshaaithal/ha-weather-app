/// Weather conditions based on WMO codes + derived conditions from STYLE_GUIDE.md
/// https://open-meteo.com/en/docs
enum WeatherCondition {
  // Clear conditions
  clearDay,
  clearNight,

  // Cloudy conditions
  partlyCloudyDay,
  partlyCloudyNight,
  cloudy,

  // Precipitation
  foggy,
  drizzle,
  rain,
  heavyRain,
  thunderstorm,
  snow,
  heavySnow,
  sleet,
  hail,

  // Derived from additional data (time, temperature, wind)
  sunrise,       // Time-based: around sunrise hour
  sunset,        // Time-based: around sunset hour
  windy,         // Wind speed > 40 km/h
  extremeHeat,   // Temperature > 35°C
  extremeCold,   // Temperature < -10°C
}

/// Resolves the most appropriate WeatherCondition based on all available data.
/// Considers WMO code, temperature, wind speed, and time of day.
class WeatherConditionResolver {
  WeatherConditionResolver._();

  /// Thresholds for derived conditions
  static const double extremeHeatThreshold = 35.0; // °C
  static const double extremeColdThreshold = -10.0; // °C
  static const double windyThreshold = 40.0; // km/h

  /// Duration around sunrise/sunset to show special theme (in minutes)
  static const int sunriseSunsetWindow = 30;

  /// Resolves the most appropriate weather condition.
  ///
  /// Priority order:
  /// 1. Severe weather (thunderstorm, hail, blizzard)
  /// 2. Precipitation (rain, snow, sleet, drizzle)
  /// 3. Extreme temperatures (only if clear/partly cloudy)
  /// 4. Sunrise/sunset time windows (only if clear/partly cloudy)
  /// 5. Windy conditions (only if clear/partly cloudy)
  /// 6. Base WMO condition
  static WeatherCondition resolve({
    required int wmoCode,
    required bool isDay,
    required double temperature,
    required double windSpeed,
    DateTime? currentTime,
    DateTime? sunrise,
    DateTime? sunset,
  }) {
    // Get base condition from WMO code
    final baseCondition = WeatherCodes.fromWmoCode(wmoCode, isDay: isDay);

    // Severe weather and precipitation take priority - don't override
    if (_isSevereOrPrecipitation(baseCondition)) {
      return baseCondition;
    }

    // Check for sunrise/sunset window (only for clear/partly cloudy conditions)
    if (_isClearOrPartlyCloudy(baseCondition) &&
        currentTime != null &&
        sunrise != null &&
        sunset != null) {
      if (_isNearSunrise(currentTime, sunrise)) {
        return WeatherCondition.sunrise;
      }
      if (_isNearSunset(currentTime, sunset)) {
        return WeatherCondition.sunset;
      }
    }

    // Check extreme temperatures (only for clear/partly cloudy)
    if (_isClearOrPartlyCloudy(baseCondition)) {
      if (temperature >= extremeHeatThreshold) {
        return WeatherCondition.extremeHeat;
      }
      if (temperature <= extremeColdThreshold) {
        return WeatherCondition.extremeCold;
      }
    }

    // Check windy conditions (only for clear/partly cloudy, not during precipitation)
    if (_isClearOrPartlyCloudy(baseCondition) && windSpeed >= windyThreshold) {
      return WeatherCondition.windy;
    }

    return baseCondition;
  }

  static bool _isSevereOrPrecipitation(WeatherCondition condition) {
    return [
      WeatherCondition.thunderstorm,
      WeatherCondition.hail,
      WeatherCondition.heavySnow,
      WeatherCondition.heavyRain,
      WeatherCondition.rain,
      WeatherCondition.snow,
      WeatherCondition.sleet,
      WeatherCondition.drizzle,
      WeatherCondition.foggy,
    ].contains(condition);
  }

  static bool _isClearOrPartlyCloudy(WeatherCondition condition) {
    return [
      WeatherCondition.clearDay,
      WeatherCondition.clearNight,
      WeatherCondition.partlyCloudyDay,
      WeatherCondition.partlyCloudyNight,
      WeatherCondition.cloudy,
    ].contains(condition);
  }

  static bool _isNearSunrise(DateTime current, DateTime sunrise) {
    final diff = current.difference(sunrise).inMinutes.abs();
    return diff <= sunriseSunsetWindow;
  }

  static bool _isNearSunset(DateTime current, DateTime sunset) {
    final diff = current.difference(sunset).inMinutes.abs();
    return diff <= sunriseSunsetWindow;
  }
}

class WeatherCodes {
  WeatherCodes._();

  /// Maps Open-Meteo WMO weather codes to our WeatherCondition.
  /// For more accurate results, use WeatherConditionResolver.resolve() instead.
  static WeatherCondition fromWmoCode(int code, {bool isDay = true}) {
    switch (code) {
      case 0: // Clear sky
        return isDay ? WeatherCondition.clearDay : WeatherCondition.clearNight;
      case 1: // Mainly clear
      case 2: // Partly cloudy
        return isDay ? WeatherCondition.partlyCloudyDay : WeatherCondition.partlyCloudyNight;
      case 3: // Overcast
        return WeatherCondition.cloudy;
      case 45: // Fog
      case 48: // Depositing rime fog
        return WeatherCondition.foggy;
      case 51: // Drizzle: Light
      case 53: // Drizzle: Moderate
      case 56: // Freezing Drizzle: Light
        return WeatherCondition.drizzle;
      case 55: // Drizzle: Dense
      case 57: // Freezing Drizzle: Dense
        return WeatherCondition.rain;
      case 61: // Rain: Slight
      case 63: // Rain: Moderate
      case 66: // Freezing Rain: Light
        return WeatherCondition.rain;
      case 65: // Rain: Heavy
      case 67: // Freezing Rain: Heavy
        return WeatherCondition.heavyRain;
      case 71: // Snow fall: Slight
      case 73: // Snow fall: Moderate
      case 77: // Snow grains
        return WeatherCondition.snow;
      case 75: // Snow fall: Heavy
      case 85: // Snow showers: Slight
      case 86: // Snow showers: Heavy
        return WeatherCondition.heavySnow;
      case 80: // Rain showers: Slight
      case 81: // Rain showers: Moderate
        return WeatherCondition.rain;
      case 82: // Rain showers: Violent
        return WeatherCondition.heavyRain;
      case 95: // Thunderstorm: Slight or moderate
        return WeatherCondition.thunderstorm;
      case 96: // Thunderstorm with slight hail
      case 99: // Thunderstorm with heavy hail
        return WeatherCondition.hail;
      default:
        return isDay ? WeatherCondition.clearDay : WeatherCondition.clearNight;
    }
  }

  /// Human-readable description for weather codes
  static String getDescription(int code) {
    switch (code) {
      case 0:
        return 'Clear sky';
      case 1:
        return 'Mainly clear';
      case 2:
        return 'Partly cloudy';
      case 3:
        return 'Overcast';
      case 45:
        return 'Foggy';
      case 48:
        return 'Rime fog';
      case 51:
        return 'Light drizzle';
      case 53:
        return 'Moderate drizzle';
      case 55:
        return 'Dense drizzle';
      case 56:
        return 'Light freezing drizzle';
      case 57:
        return 'Dense freezing drizzle';
      case 61:
        return 'Slight rain';
      case 63:
        return 'Moderate rain';
      case 65:
        return 'Heavy rain';
      case 66:
        return 'Light freezing rain';
      case 67:
        return 'Heavy freezing rain';
      case 71:
        return 'Slight snow';
      case 73:
        return 'Moderate snow';
      case 75:
        return 'Heavy snow';
      case 77:
        return 'Snow grains';
      case 80:
        return 'Slight rain showers';
      case 81:
        return 'Moderate rain showers';
      case 82:
        return 'Violent rain showers';
      case 85:
        return 'Slight snow showers';
      case 86:
        return 'Heavy snow showers';
      case 95:
        return 'Thunderstorm';
      case 96:
        return 'Thunderstorm with hail';
      case 99:
        return 'Thunderstorm with heavy hail';
      default:
        return 'Unknown';
    }
  }
}
