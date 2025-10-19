// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:weather_app/feature/search/domain/repo/search_repository.dart';
import '../../../../core/errors/failures.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository repository;

  SearchCubit({
    required this.repository,
    required SearchRepository searchRepository,
  }) : super(SearchInitial());

  Future<void> search(String query) async {
    final q = query.trim();
    if (q.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    try {
      final results = await repository.search(q);
      if (results.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchLoaded(results: results));
      }
    } on Failure catch (f) {
      emit(SearchError(failure: f));
    } catch (e) {
      emit(SearchError(failure: ServerFailure(message: e.toString())));
    }
  }
}
