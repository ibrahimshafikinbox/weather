import 'package:weather_app/feature/search/domain/repo/search_repository.dart';

import '../models/location_model.dart';
import '../services/search_service.dart';
import '../../../../core/errors/failures.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchService service;

  SearchRepositoryImpl({required this.service});

  @override
  Future<List<LocationModel>> search(String query) async {
    if (query.trim().isEmpty) return [];
    try {
      return await service.searchLocations(query);
    } on Failure {
      rethrow;
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}
