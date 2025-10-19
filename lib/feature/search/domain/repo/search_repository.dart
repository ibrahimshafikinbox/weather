import '../../data/models/location_model.dart';

abstract class SearchRepository {
  Future<List<LocationModel>> search(String query);
}
