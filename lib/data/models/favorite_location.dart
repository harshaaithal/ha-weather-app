import 'package:hive/hive.dart';

part 'favorite_location.g.dart';

/// A favorited location saved locally or synced to cloud.
/// Uses Hive for local persistence.
@HiveType(typeId: 0)
class FavoriteLocation extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double latitude;

  @HiveField(3)
  final double longitude;

  @HiveField(4)
  final String? country;

  @HiveField(5)
  final String? admin1; // State/Province

  @HiveField(6)
  final String? timezone;

  @HiveField(7)
  final DateTime addedAt;

  FavoriteLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.country,
    this.admin1,
    this.timezone,
    required this.addedAt,
  });

  /// Create a FavoriteLocation from a Weather Location model.
  factory FavoriteLocation.fromLocation({
    required double latitude,
    required double longitude,
    required String name,
    String? country,
    String? admin1,
    String? timezone,
  }) {
    return FavoriteLocation(
      id: '${latitude.toStringAsFixed(4)}_${longitude.toStringAsFixed(4)}',
      name: name,
      latitude: latitude,
      longitude: longitude,
      country: country,
      admin1: admin1,
      timezone: timezone,
      addedAt: DateTime.now(),
    );
  }

  /// Create from Firestore document (for cloud sync).
  factory FavoriteLocation.fromFirestore(Map<String, dynamic> data) {
    return FavoriteLocation(
      id: data['id'] as String,
      name: data['name'] as String,
      latitude: (data['latitude'] as num).toDouble(),
      longitude: (data['longitude'] as num).toDouble(),
      country: data['country'] as String?,
      admin1: data['admin1'] as String?,
      timezone: data['timezone'] as String?,
      addedAt: DateTime.parse(data['addedAt'] as String),
    );
  }

  /// Convert to map for Firestore.
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'country': country,
      'admin1': admin1,
      'timezone': timezone,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  /// Display name with optional region/country.
  String get displayName {
    final parts = <String>[name];
    if (admin1 != null && admin1!.isNotEmpty) {
      parts.add(admin1!);
    }
    if (country != null && country!.isNotEmpty) {
      parts.add(country!);
    }
    return parts.length > 1 ? '${parts[0]}, ${parts.sublist(1).join(', ')}' : name;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FavoriteLocation && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'FavoriteLocation($name, $latitude, $longitude)';
}
