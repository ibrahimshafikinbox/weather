import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/favorite/data/models/favorite_location_model.dart.dart';
import 'package:weather_app/feature/favorite/domain/favorites_repository.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository _repository;

  FavoritesCubit({required FavoritesRepository repository})
    : _repository = repository,
      super(const FavoritesInitialState());

  Future<void> loadFavorites() async {
    try {
      emit(const FavoritesLoadingState());
      final favorites = await _repository.getAllFavorites();

      final favoriteKeys = favorites
          .map((fav) => _generateKey(fav.latitude, fav.longitude))
          .toSet();

      emit(
        FavoritesLoadedState(favorites: favorites, favoriteKeys: favoriteKeys),
      );
    } catch (e) {
      emit(FavoritesErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> toggleFavorite({
    required String name,
    required String country,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final isFav = await _repository.isFavorite(latitude, longitude);

      if (isFav) {
        await _repository.removeFavoriteByCoordinates(latitude, longitude);
        emit(FavoriteToggleSuccessState(isAdded: false, locationName: name));
      } else {
        final favorite = FavoriteLocationModel(
          name: name,
          country: country,
          latitude: latitude,
          longitude: longitude,
          addedAt: DateTime.now(),
        );
        await _repository.addFavorite(favorite);
        emit(FavoriteToggleSuccessState(isAdded: true, locationName: name));
      }

      // Reload favorites
      await loadFavorites();
    } catch (e) {
      emit(FavoritesErrorState(errorMessage: e.toString()));
    }
  }

  Future<bool> checkIsFavorite(double latitude, double longitude) async {
    try {
      return await _repository.isFavorite(latitude, longitude);
    } catch (e) {
      return false;
    }
  }

  Future<void> removeFavorite(int id) async {
    try {
      await _repository.removeFavorite(id);
      await loadFavorites();
    } catch (e) {
      emit(FavoritesErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> clearAll() async {
    try {
      await _repository.clearAllFavorites();
      await loadFavorites();
    } catch (e) {
      emit(FavoritesErrorState(errorMessage: e.toString()));
    }
  }

  String _generateKey(double latitude, double longitude) {
    return '${latitude.toStringAsFixed(4)}_${longitude.toStringAsFixed(4)}';
  }
}
