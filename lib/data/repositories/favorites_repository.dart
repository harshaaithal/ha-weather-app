import '../models/favorite_location.dart';

/// Abstract repository for favorite locations.
/// Implemented by HiveFavoritesService (local) and FirestoreFavoritesService (cloud).
abstract class FavoritesRepository {
  /// Maximum number of favorites allowed.
  int get maxFavorites;

  /// Gets all favorite locations, ordered by addedAt (newest first).
  Future<List<FavoriteLocation>> getAll();

  /// Adds a location to favorites.
  /// Returns true if added successfully, false if limit reached or already exists.
  Future<bool> add(FavoriteLocation location);

  /// Removes a location from favorites by ID.
  /// Returns true if removed successfully.
  Future<bool> remove(String id);

  /// Checks if a location is already a favorite.
  Future<bool> isFavorite(String id);

  /// Checks if a location is a favorite by coordinates.
  Future<bool> isFavoriteByCoords(double latitude, double longitude);

  /// Reorders favorites (for drag-and-drop support).
  Future<void> reorder(List<FavoriteLocation> newOrder);

  /// Gets the current count of favorites.
  Future<int> count();

  /// Checks if can add more favorites.
  Future<bool> canAddMore() async {
    final currentCount = await count();
    return currentCount < maxFavorites;
  }

  /// Clears all favorites (for account deletion or testing).
  Future<void> clear();

  /// Stream of favorites for real-time updates.
  Stream<List<FavoriteLocation>> watchAll();
}
