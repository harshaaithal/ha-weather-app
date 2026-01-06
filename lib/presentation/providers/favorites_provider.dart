import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/favorite_location.dart';
import '../../data/models/weather.dart';
import '../../data/repositories/favorites_repository.dart';
import '../../data/services/hive_favorites_service.dart';

/// Provider for the FavoritesRepository implementation.
/// Currently uses Hive for local storage (free tier: 5 favorites).
/// Will be extended to support Firestore for Pro users (10 favorites).
final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return HiveFavoritesService(maxFavorites: 5);
});

/// State class for favorites management.
class FavoritesState {
  final List<FavoriteLocation> favorites;
  final bool isLoading;
  final String? error;
  final int maxFavorites;

  const FavoritesState({
    this.favorites = const [],
    this.isLoading = false,
    this.error,
    this.maxFavorites = 5,
  });

  FavoritesState copyWith({
    List<FavoriteLocation>? favorites,
    bool? isLoading,
    String? error,
    int? maxFavorites,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      maxFavorites: maxFavorites ?? this.maxFavorites,
    );
  }

  bool get canAddMore => favorites.length < maxFavorites;
  int get remaining => maxFavorites - favorites.length;
}

/// Notifier for managing favorites state.
class FavoritesNotifier extends StateNotifier<FavoritesState> {
  final FavoritesRepository _repository;

  FavoritesNotifier(this._repository) : super(const FavoritesState()) {
    _loadFavorites();
  }

  /// Loads favorites from storage.
  Future<void> _loadFavorites() async {
    state = state.copyWith(isLoading: true);
    try {
      final favorites = await _repository.getAll();
      state = state.copyWith(
        favorites: favorites,
        isLoading: false,
        maxFavorites: _repository.maxFavorites,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load favorites: $e',
      );
    }
  }

  /// Adds a location to favorites from the current weather.
  Future<bool> addFromWeather(Weather weather) async {
    final location = weather.location;
    final favorite = FavoriteLocation.fromLocation(
      latitude: location.latitude,
      longitude: location.longitude,
      name: location.name,
      country: location.country,
      admin1: location.admin1,
      timezone: location.timezone,
    );

    return addFavorite(favorite);
  }

  /// Adds a favorite location.
  Future<bool> addFavorite(FavoriteLocation location) async {
    if (!state.canAddMore) {
      state = state.copyWith(
        error: 'Maximum favorites limit reached (${state.maxFavorites})',
      );
      return false;
    }

    try {
      final success = await _repository.add(location);
      if (success) {
        await _loadFavorites();
        return true;
      } else {
        state = state.copyWith(error: 'Location already in favorites');
        return false;
      }
    } catch (e) {
      state = state.copyWith(error: 'Failed to add favorite: $e');
      return false;
    }
  }

  /// Removes a favorite by ID.
  Future<bool> removeFavorite(String id) async {
    try {
      final success = await _repository.remove(id);
      if (success) {
        await _loadFavorites();
        return true;
      }
      return false;
    } catch (e) {
      state = state.copyWith(error: 'Failed to remove favorite: $e');
      return false;
    }
  }

  /// Removes a favorite by coordinates.
  Future<bool> removeFavoriteByCoords(double latitude, double longitude) async {
    final id = '${latitude.toStringAsFixed(4)}_${longitude.toStringAsFixed(4)}';
    return removeFavorite(id);
  }

  /// Checks if a location is a favorite.
  bool isFavorite(double latitude, double longitude) {
    final id = '${latitude.toStringAsFixed(4)}_${longitude.toStringAsFixed(4)}';
    return state.favorites.any((f) => f.id == id);
  }

  /// Toggles favorite status for the current weather location.
  Future<bool> toggleFavorite(Weather weather) async {
    final location = weather.location;
    if (isFavorite(location.latitude, location.longitude)) {
      return removeFavoriteByCoords(location.latitude, location.longitude);
    } else {
      return addFromWeather(weather);
    }
  }

  /// Reorders favorites.
  Future<void> reorder(List<FavoriteLocation> newOrder) async {
    try {
      await _repository.reorder(newOrder);
      state = state.copyWith(favorites: newOrder);
    } catch (e) {
      state = state.copyWith(error: 'Failed to reorder favorites: $e');
    }
  }

  /// Clears all favorites.
  Future<void> clearAll() async {
    try {
      await _repository.clear();
      state = state.copyWith(favorites: []);
    } catch (e) {
      state = state.copyWith(error: 'Failed to clear favorites: $e');
    }
  }

  /// Clears any error message.
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Refreshes favorites from storage.
  Future<void> refresh() async {
    await _loadFavorites();
  }
}

/// Provider for the FavoritesNotifier.
final favoritesNotifierProvider =
    StateNotifierProvider<FavoritesNotifier, FavoritesState>((ref) {
  final repository = ref.watch(favoritesRepositoryProvider);
  return FavoritesNotifier(repository);
});

/// Convenience provider for checking if current weather location is a favorite.
final isCurrentLocationFavoriteProvider = Provider.family<bool, Weather?>((ref, weather) {
  if (weather == null) return false;
  final favoritesState = ref.watch(favoritesNotifierProvider);
  final id = '${weather.location.latitude.toStringAsFixed(4)}_${weather.location.longitude.toStringAsFixed(4)}';
  return favoritesState.favorites.any((f) => f.id == id);
});
