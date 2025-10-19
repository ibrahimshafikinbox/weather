import 'package:equatable/equatable.dart';
import 'package:weather_app/feature/favorite/data/models/favorite_location_model.dart.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitialState extends FavoritesState {
  const FavoritesInitialState();
}

class FavoritesLoadingState extends FavoritesState {
  const FavoritesLoadingState();
}

class FavoritesLoadedState extends FavoritesState {
  final List<FavoriteLocationModel> favorites;
  final Set<String> favoriteKeys;

  const FavoritesLoadedState({
    required this.favorites,
    required this.favoriteKeys,
  });

  bool isFavorite(double latitude, double longitude) {
    final key = _generateKey(latitude, longitude);
    return favoriteKeys.contains(key);
  }

  static String _generateKey(double latitude, double longitude) {
    return '${latitude.toStringAsFixed(4)}_${longitude.toStringAsFixed(4)}';
  }

  @override
  List<Object?> get props => [favorites, favoriteKeys];
}

class FavoritesErrorState extends FavoritesState {
  final String errorMessage;

  const FavoritesErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class FavoriteToggleSuccessState extends FavoritesState {
  final bool isAdded;
  final String locationName;

  const FavoriteToggleSuccessState({
    required this.isAdded,
    required this.locationName,
  });

  @override
  List<Object?> get props => [isAdded, locationName];
}
