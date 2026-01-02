import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
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

    try {
      final placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        cityName = place.locality ??
                   place.subAdministrativeArea ??
                   place.administrativeArea ??
                   'Current Location';
        country = place.country;
        admin1 = place.administrativeArea;
      }
    } catch (_) {
      // Geocoding failed, use default name
    }

    return Location(
      latitude: position.latitude,
      longitude: position.longitude,
      name: cityName,
      country: country,
      admin1: admin1,
    );
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
