/// WMO Weather interpretation codes (WW)
/// https://open-meteo.com/en/docs
enum WeatherCondition {
  clearDay,
  clearNight,
  partlyCloudyDay,
  partlyCloudyNight,
  cloudy,
  foggy,
  drizzle,
  rain,
  heavyRain,
  thunderstorm,
  snow,
  heavySnow,
  sleet,
  hail,
}

class WeatherCodes {
  WeatherCodes._();

  /// Maps Open-Meteo WMO weather codes to our WeatherCondition
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
