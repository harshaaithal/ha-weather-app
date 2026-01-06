import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/favorite_location.dart';
import '../repositories/favorites_repository.dart';

/// Hive-based local storage implementation of FavoritesRepository.
/// Used for free tier users (up to 5 favorites).
class HiveFavoritesService extends FavoritesRepository {
  static const String _boxName = 'favorites';

  final int _maxFavorites;
  Box<FavoriteLocation>? _box;

  /// Stream controller for broadcasting changes.
  final _favoritesController = StreamController<List<FavoriteLocation>>.broadcast();

  HiveFavoritesService({int maxFavorites = 5}) : _maxFavorites = maxFavorites;

  @override
  int get maxFavorites => _maxFavorites;

  /// Gets the Hive box, opening it if necessary.
  Future<Box<FavoriteLocation>> _getBox() async {
    if (_box != null && _box!.isOpen) {
      return _box!;
    }
    _box = await Hive.openBox<FavoriteLocation>(_boxName);
    return _box!;
  }

  /// Notifies listeners of changes.
  void _notifyListeners() async {
    final favorites = await getAll();
    _favoritesController.add(favorites);
  }

  @override
  Future<List<FavoriteLocation>> getAll() async {
    final box = await _getBox();
    final favorites = box.values.toList();
    // Sort by addedAt (newest first)
    favorites.sort((a, b) => b.addedAt.compareTo(a.addedAt));
    return favorites;
  }

  @override
  Future<bool> add(FavoriteLocation location) async {
    final box = await _getBox();

    // Check if already exists
    if (box.containsKey(location.id)) {
      return false;
    }

    // Check limit
    if (box.length >= _maxFavorites) {
      return false;
    }

    await box.put(location.id, location);
    _notifyListeners();
    return true;
  }

  @override
  Future<bool> remove(String id) async {
    final box = await _getBox();

    if (!box.containsKey(id)) {
      return false;
    }

    await box.delete(id);
    _notifyListeners();
    return true;
  }

  @override
  Future<bool> isFavorite(String id) async {
    final box = await _getBox();
    return box.containsKey(id);
  }

  @override
  Future<bool> isFavoriteByCoords(double latitude, double longitude) async {
    final id = '${latitude.toStringAsFixed(4)}_${longitude.toStringAsFixed(4)}';
    return isFavorite(id);
  }

  @override
  Future<void> reorder(List<FavoriteLocation> newOrder) async {
    final box = await _getBox();

    // Clear and re-add in new order with updated timestamps
    await box.clear();

    // Add in reverse order so newest-first ordering is maintained
    for (var i = newOrder.length - 1; i >= 0; i--) {
      final location = newOrder[i];
      final updated = FavoriteLocation(
        id: location.id,
        name: location.name,
        latitude: location.latitude,
        longitude: location.longitude,
        country: location.country,
        admin1: location.admin1,
        timezone: location.timezone,
        addedAt: DateTime.now().subtract(Duration(seconds: i)),
      );
      await box.put(updated.id, updated);
    }

    _notifyListeners();
  }

  @override
  Future<int> count() async {
    final box = await _getBox();
    return box.length;
  }

  @override
  Future<void> clear() async {
    final box = await _getBox();
    await box.clear();
    _notifyListeners();
  }

  @override
  Stream<List<FavoriteLocation>> watchAll() {
    // Emit current state immediately, then listen for changes
    getAll().then((favorites) => _favoritesController.add(favorites));
    return _favoritesController.stream;
  }

  /// Disposes resources.
  void dispose() {
    _favoritesController.close();
  }
}
