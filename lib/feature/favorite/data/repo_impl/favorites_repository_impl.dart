import 'package:sqflite/sqflite.dart';
import 'package:weather_app/core/helper/storage/storage_helper.dart';
import 'package:weather_app/feature/favorite/data/models/favorite_location_model.dart.dart';
import 'package:weather_app/feature/favorite/domain/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final DatabaseHelper _databaseHelper;

  FavoritesRepositoryImpl({DatabaseHelper? databaseHelper})
    : _databaseHelper = databaseHelper ?? DatabaseHelper.instance;

  static const String _tableName = 'favorites';

  @override
  Future<void> addFavorite(FavoriteLocationModel location) async {
    try {
      final db = await _databaseHelper.database;
      await db.insert(
        _tableName,
        location.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception('Failed to add favorite: $e');
    }
  }

  @override
  Future<void> removeFavorite(int id) async {
    try {
      final db = await _databaseHelper.database;
      await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception('Failed to remove favorite: $e');
    }
  }

  @override
  Future<void> removeFavoriteByCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final db = await _databaseHelper.database;
      await db.delete(
        _tableName,
        where: 'latitude = ? AND longitude = ?',
        whereArgs: [latitude, longitude],
      );
    } catch (e) {
      throw Exception('Failed to remove favorite by coordinates: $e');
    }
  }

  @override
  Future<List<FavoriteLocationModel>> getAllFavorites() async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        orderBy: 'added_at DESC',
      );

      return maps.map((map) => FavoriteLocationModel.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to get favorites: $e');
    }
  }

  @override
  Future<bool> isFavorite(double latitude, double longitude) async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        where: 'latitude = ? AND longitude = ?',
        whereArgs: [latitude, longitude],
        limit: 1,
      );

      return maps.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check favorite status: $e');
    }
  }

  @override
  Future<FavoriteLocationModel?> getFavoriteByCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        where: 'latitude = ? AND longitude = ?',
        whereArgs: [latitude, longitude],
        limit: 1,
      );

      if (maps.isEmpty) return null;
      return FavoriteLocationModel.fromMap(maps.first);
    } catch (e) {
      throw Exception('Failed to get favorite by coordinates: $e');
    }
  }

  @override
  Future<void> clearAllFavorites() async {
    try {
      final db = await _databaseHelper.database;
      await db.delete(_tableName);
    } catch (e) {
      throw Exception('Failed to clear favorites: $e');
    }
  }
}
