// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:weather_app/feature/layout/Widgets/custom_bottom_nav_bar.dart';
// import 'package:weather_app/feature/layout/view/layout_view.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(390, 844),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//             textTheme: ThemeData.light().textTheme.apply(
//               bodyColor: Colors.white,
//               displayColor: Colors.white,
//             ),
//           ),
//           home: child,
//         );
//       },
//       child: const MainView(),
//     );
//   }
// }
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Core
import 'package:weather_app/core/constants/api_constants.dart';
import 'package:weather_app/core/network/api_client.dart';
import 'package:weather_app/feature/favorite/data/repo_impl/favorites_repository_impl.dart';
import 'package:weather_app/feature/favorite/domain/favorites_repository.dart';
import 'package:weather_app/feature/favorite/presentation/cubit/favorites_cubit.dart';

// Layout
import 'package:weather_app/feature/layout/view/layout_view.dart';

// Home / Weather Feature
import 'package:weather_app/feature/home/data/repo_impl/home_weather_repository_impl.dart';
import 'package:weather_app/feature/home/data/services/home_weather_service.dart';
import 'package:weather_app/feature/home/domain/repo/home_weather_repository.dart';
import 'package:weather_app/feature/home/presentation/cubit/weather_cubit.dart';

// Search Feature
import 'package:weather_app/feature/search/data/repo_impl/search_repository_impl.dart';
import 'package:weather_app/feature/search/data/services/search_service.dart';
import 'package:weather_app/feature/search/domain/repo/search_repository.dart';
import 'package:weather_app/feature/search/presentation/cubit/search_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final apiClient = ApiClient(dio: dio);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WeatherRepository>(
          create: (_) => WeatherRepositoryImpl(
            weatherService: WeatherService(apiClient: apiClient),
          ),
        ),
        RepositoryProvider<FavoritesRepository>(
          create: (_) => FavoritesRepositoryImpl(),
        ),
        RepositoryProvider<SearchRepository>(
          create: (_) => SearchRepositoryImpl(
            service: SearchService(
              apiClient: apiClient,
              apiKey: ApiConstants.apiKey,
            ),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
              weatherRepository: context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider<FavoritesCubit>(
            create: (context) =>
                FavoritesCubit(repository: FavoritesRepositoryImpl()),
          ),
          BlocProvider<SearchCubit>(
            create: (context) => SearchCubit(
              searchRepository: context.read<SearchRepository>(),
              repository: context.read<SearchRepository>(),
            ),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                textTheme: ThemeData.light().textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
              ),
              home: child,
            );
          },
          child: const MainView(),
        ),
      ),
    );
  }
}
