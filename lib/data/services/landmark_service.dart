/// Service for resolving city landmarks with intelligent fallback logic.
///
/// Maps cities to their landmark images, falling back to regional/climate-based
/// generic landmarks when a city-specific image isn't available.
class LandmarkService {
  static const String _basePath = 'assets/landmarks';
  static const String _citiesPath = '$_basePath/cities';
  static const String _fallbacksPath = '$_basePath/fallbacks';

  /// Maps normalized city names to their asset filenames.
  /// Keys are lowercase with underscores (e.g., "new_york", "hong_kong").
  static const Map<String, String> _cityAssets = {
    // Americas
    'new_york': 'new_york.png',
    'new york': 'new_york.png',
    'new york city': 'new_york.png',
    'nyc': 'new_york.png',
    'los_angeles': 'los_angeles.png',
    'los angeles': 'los_angeles.png',
    'la': 'los_angeles.png',
    'san_francisco': 'san_francisco.png',
    'san francisco': 'san_francisco.png',
    'sf': 'san_francisco.png',
    'chicago': 'chicago.png',
    'seattle': 'seattle.png',
    'las_vegas': 'las_vegas.png',
    'las vegas': 'las_vegas.png',
    'vegas': 'las_vegas.png',
    'toronto': 'toronto.png',
    'rio_de_janeiro': 'rio.png',
    'rio de janeiro': 'rio.png',
    'rio': 'rio.png',

    // Europe
    'london': 'london.png',
    'paris': 'paris.png',
    'rome': 'rome.png',
    'roma': 'rome.png',
    'barcelona': 'barcelona.png',
    'berlin': 'berlin.png',
    'amsterdam': 'amsterdam.png',
    'prague': 'prague.png',
    'praha': 'prague.png',
    'athens': 'athens.png',
    'moscow': 'moscow.png',
    'moskva': 'moscow.png',

    // Middle East & Africa
    'dubai': 'dubai.png',
    'istanbul': 'istanbul.png',
    'cairo': 'cairo.png',

    // Asia
    'tokyo': 'tokyo.png',
    'beijing': 'beijing.png',
    'peking': 'beijing.png',
    'shanghai': 'shanghai.png',
    'hong_kong': 'hong_kong.png',
    'hong kong': 'hong_kong.png',
    'singapore': 'singapore.png',
    'seoul': 'seoul.png',
    'bangkok': 'bangkok.png',
    'kuala_lumpur': 'kuala_lumpur.png',
    'kuala lumpur': 'kuala_lumpur.png',
    'kl': 'kuala_lumpur.png',
    'mumbai': 'mumbai.png',
    'bombay': 'mumbai.png',

    // Oceania
    'sydney': 'sydney.png',
  };

  /// Country to region mapping for fallback selection.
  static const Map<String, String> _countryToRegion = {
    // Asian countries → asian_metro fallback
    'japan': 'asian',
    'china': 'asian',
    'south korea': 'asian',
    'korea': 'asian',
    'taiwan': 'asian',
    'vietnam': 'asian',
    'thailand': 'asian',
    'malaysia': 'asian',
    'indonesia': 'asian',
    'philippines': 'asian',
    'singapore': 'asian',
    'hong kong': 'asian',

    // European countries → european_historic fallback
    'united kingdom': 'european',
    'uk': 'european',
    'france': 'european',
    'germany': 'european',
    'italy': 'european',
    'spain': 'european',
    'portugal': 'european',
    'netherlands': 'european',
    'belgium': 'european',
    'austria': 'european',
    'switzerland': 'european',
    'poland': 'european',
    'czech republic': 'european',
    'czechia': 'european',
    'hungary': 'european',
    'greece': 'european',
    'sweden': 'european',
    'norway': 'european',
    'denmark': 'european',
    'finland': 'european',
    'ireland': 'european',

    // Middle East → desert fallback
    'united arab emirates': 'desert',
    'uae': 'desert',
    'saudi arabia': 'desert',
    'qatar': 'desert',
    'bahrain': 'desert',
    'kuwait': 'desert',
    'oman': 'desert',
    'egypt': 'desert',
    'jordan': 'desert',
    'israel': 'desert',

    // Tropical countries → tropical fallback
    'brazil': 'tropical',
    'mexico': 'tropical',
    'colombia': 'tropical',
    'peru': 'tropical',
    'venezuela': 'tropical',
    'costa rica': 'tropical',
    'panama': 'tropical',
    'cuba': 'tropical',
    'jamaica': 'tropical',
    'dominican republic': 'tropical',
    'puerto rico': 'tropical',
    'india': 'tropical',
    'sri lanka': 'tropical',

    // Modern metro countries → modern_metro fallback
    'united states': 'modern',
    'usa': 'modern',
    'canada': 'modern',
    'australia': 'modern',
    'new zealand': 'modern',

    // Russia → european (Moscow style)
    'russia': 'european',
    'turkey': 'european',
  };

  /// Fallback asset filenames by region type.
  static const Map<String, String> _fallbackAssets = {
    'asian': 'asian_metro.png',
    'european': 'european_historic.png',
    'modern': 'modern_metro.png',
    'tropical': 'tropical.png',
    'desert': 'desert.png',
    'coastal': 'coastal.png',
    'mountain': 'mountain.png',
    'rural': 'rural.png',
  };

  /// Resolves the landmark asset path for a given location.
  ///
  /// Priority:
  /// 1. Exact city name match
  /// 2. Country-based regional fallback
  /// 3. Latitude-based climate fallback
  /// 4. Default modern_metro fallback
  static String resolveLandmarkPath({
    required String cityName,
    String? country,
    double? latitude,
  }) {
    // 1. Try exact city match
    final normalizedCity = _normalize(cityName);
    if (_cityAssets.containsKey(normalizedCity)) {
      return '$_citiesPath/${_cityAssets[normalizedCity]}';
    }

    // 2. Try country-based fallback
    if (country != null) {
      final normalizedCountry = _normalize(country);
      if (_countryToRegion.containsKey(normalizedCountry)) {
        final region = _countryToRegion[normalizedCountry]!;
        return '$_fallbacksPath/${_fallbackAssets[region]}';
      }
    }

    // 3. Try latitude-based fallback
    if (latitude != null) {
      return '$_fallbacksPath/${_getLatitudeBasedFallback(latitude)}';
    }

    // 4. Default fallback
    return '$_fallbacksPath/${_fallbackAssets['modern']}';
  }

  /// Gets a fallback based on latitude (climate zones).
  static String _getLatitudeBasedFallback(double latitude) {
    final absLat = latitude.abs();

    if (absLat < 23.5) {
      // Tropical zone (between Tropics of Cancer and Capricorn)
      return _fallbackAssets['tropical']!;
    } else if (absLat < 35) {
      // Subtropical - could be desert or coastal
      return _fallbackAssets['coastal']!;
    } else if (absLat < 55) {
      // Temperate zone
      return _fallbackAssets['modern']!;
    } else {
      // High latitude - often mountainous/rural
      return _fallbackAssets['mountain']!;
    }
  }

  /// Normalizes a string for matching (lowercase, trimmed).
  static String _normalize(String input) {
    return input.toLowerCase().trim();
  }

  /// Checks if a specific city has a dedicated landmark asset.
  static bool hasCityLandmark(String cityName) {
    return _cityAssets.containsKey(_normalize(cityName));
  }

  /// Gets all available city landmarks.
  static List<String> get availableCities => _cityAssets.keys.toList();

  /// Gets all fallback types.
  static List<String> get fallbackTypes => _fallbackAssets.keys.toList();
}
