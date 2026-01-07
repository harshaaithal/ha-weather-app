import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:dio/dio.dart';
import '../models/weather.dart';

/// Service for handling device location and reverse geocoding.
class LocationService {
  /// Checks if location services are enabled and permissions are granted.
  /// Returns true if ready to use, throws exception otherwise.
  Future<bool> checkPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationException('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationException('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationException(
        'Location permissions are permanently denied. '
        'Please enable them in settings.',
      );
    }

    return true;
  }

  /// Gets the current device position.
  Future<Position> getCurrentPosition() async {
    await checkPermissions();

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.low, // Low accuracy is faster and sufficient for weather
        timeLimit: Duration(seconds: 10),
      ),
    );
  }

  /// Gets current location with city name via reverse geocoding.
  Future<Location> getCurrentLocation() async {
    final position = await getCurrentPosition();

    String cityName = 'Current Location';
    String? country;
    String? admin1;

    // Try device geocoding first
    try {
      final placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final name = place.locality ??
                     place.subAdministrativeArea ??
                     place.administrativeArea;
        if (name != null && name.isNotEmpty) {
          cityName = name;
        }
        country = place.country;
        admin1 = place.administrativeArea;
      }
    } catch (_) {
      // Device geocoding failed, will try Open-Meteo fallback
    }

    // If device geocoding failed, try BigDataCloud reverse geocoding
    if (cityName == 'Current Location') {
      try {
        final result = await _reverseGeocodeWithBigDataCloud(
          position.latitude,
          position.longitude,
        );
        if (result != null) {
          final name = result['name'];
          if (name != null && name.isNotEmpty) {
            cityName = name;
          }
          country = result['country'] ?? country;
          admin1 = result['admin1'] ?? admin1;
        }
      } catch (_) {
        // BigDataCloud fallback also failed
      }
    }

    return Location(
      latitude: position.latitude,
      longitude: position.longitude,
      name: cityName,
      country: country,
      admin1: admin1,
    );
  }

  /// Reverse geocode using BigDataCloud's free API (no API key required).
  Future<Map<String, String>?> _reverseGeocodeWithBigDataCloud(
    double latitude,
    double longitude,
  ) async {
    final dio = Dio();

    final response = await dio.get(
      'https://api.bigdatacloud.net/data/reverse-geocode-client',
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'localityLanguage': 'en',
      },
    );

    if (response.data != null) {
      final data = response.data;
      return {
        'name': data['city'] ?? data['locality'] ?? data['principalSubdivision'],
        'country': data['countryName'],
        'admin1': data['principalSubdivision'],
      };
    }
    return null;
  }

  /// Gets the last known position (faster, may be stale).
  Future<Position?> getLastKnownPosition() async {
    return await Geolocator.getLastKnownPosition();
  }

  /// Opens the device location settings.
  Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }

  /// Opens the app settings (for permission management).
  Future<bool> openAppSettings() async {
    return await Geolocator.openAppSettings();
  }
}

/// Exception for location-related errors.
class LocationException implements Exception {
  final String message;

  LocationException(this.message);

  @override
  String toString() => message;
}
