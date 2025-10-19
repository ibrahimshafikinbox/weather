// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:weather_app/core/constants/api_constants.dart';
// import 'package:weather_app/core/network/api_client.dart';

// // Home / Weather imports
// import 'package:weather_app/feature/home/data/repo_impl/home_weather_repository_impl.dart';
// import 'package:weather_app/feature/home/data/services/home_weather_service.dart';
// import 'package:weather_app/feature/home/domain/repo/home_weather_repository.dart';
// import 'package:weather_app/feature/home/presentation/cubit/weather_cubit.dart';
// import 'package:weather_app/feature/search/data/repo_impl/search_repository_impl.dart';

// import 'package:weather_app/feature/search/data/services/search_service.dart';
// import 'package:weather_app/feature/search/domain/repo/search_repository.dart';
// import 'package:weather_app/feature/search/presentation/cubit/search_cubit.dart';

// List<RepositoryProvider> buildRepositories() {
//   return [
//     RepositoryProvider<WeatherRepository>(
//       create: (_) => WeatherRepositoryImpl(
//         weatherService: WeatherService(apiClient: ApiClient(dio: Dio())),
//       ),
//     ),
//     RepositoryProvider<SearchRepository>(
//       create: (_) => SearchRepositoryImpl(
//         service: SearchService(
//           apiClient: ApiClient(dio: Dio()),
//           apiKey: ApiConstants.apiKey,
//         ),
//       ),
//     ),
//   ];
// }

// List<BlocProvider> buildBlocs() {
//   return [
//     BlocProvider<WeatherCubit>(
//       create: (context) =>
//           WeatherCubit(weatherRepository: context.read<WeatherRepository>()),
//     ),
//     BlocProvider<SearchCubit>(
//       create: (context) => SearchCubit(
//         searchRepository: context.read<SearchRepository>(),
//         repository: SearchRepositoryImpl(
//           service: SearchService(
//             apiClient: ApiClient(dio: Dio()),
//             apiKey: ApiConstants.apiKey,
//           ),
//         ),
//       ),
//     ),
//   ];
// }
