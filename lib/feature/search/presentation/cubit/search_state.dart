// lib/feature/search/presentation/cubit/search_state.dart
import 'package:equatable/equatable.dart';
import '../../data/models/location_model.dart';
import '../../../../core/errors/failures.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<LocationModel> results;
  const SearchLoaded({required this.results});

  @override
  List<Object?> get props => [results];
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final Failure failure;
  const SearchError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
