import 'package:weather_app/feature/favorite/data/models/favorite_location_model.dart.dart';

abstract class FavoritesRepository {
  /// Adds a location to favorites
  Future<void> addFavorite(FavoriteLocationModel location);

  /// Removes a location from favorites
  Future<void> removeFavorite(int id);

  /// Removes a location by coordinates
  Future<void> removeFavoriteByCoordinates(double latitude, double longitude);

  /// Gets all favorite locations
  Future<List<FavoriteLocationModel>> getAllFavorites();

  /// Checks if a location is favorite
  Future<bool> isFavorite(double latitude, double longitude);

  /// Gets a favorite by coordinates
  Future<FavoriteLocationModel?> getFavoriteByCoordinates(
    double latitude,
    double longitude,
  );

  /// Clears all favorites
  Future<void> clearAllFavorites();
}
