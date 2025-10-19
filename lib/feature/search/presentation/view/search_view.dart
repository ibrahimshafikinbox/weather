import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/feature/favorite/presentation/cubit/favorites_cubit.dart';
import 'package:weather_app/feature/favorite/presentation/cubit/favorites_state.dart';
import 'package:weather_app/feature/search/presentation/widget/city_search_field.dart';
import 'package:weather_app/feature/search/presentation/widget/search_empty.dart';
import 'package:weather_app/feature/search/presentation/widget/search_error.dart';
import 'package:weather_app/feature/search/presentation/widget/weather_card.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';
import '../../../../core/utils/colors/app_colors.dart';
import '../../../../core/utils/styles/app_text_styles.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldbg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Weather", style: AppTextStyle.bodyText16)],
              ),
              SizedBox(height: 30.h),

              CitySearchField(
                hint: 'search city...',
                onChanged: (value) {
                  context.read<SearchCubit>().search(value);
                },
              ),

              SizedBox(height: 12.h),

              Expanded(
                child: BlocConsumer<FavoritesCubit, FavoritesState>(
                  listener: (context, favState) {
                    if (favState is FavoriteToggleSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            favState.isAdded
                                ? '❤️ ${favState.locationName} added to favorites'
                                : '💔 ${favState.locationName} removed from favorites',
                          ),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: favState.isAdded
                              ? Colors.green
                              : Colors.orange,
                        ),
                      );
                    }

                    if (favState is FavoritesErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: ${favState.errorMessage}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },

                  builder: (context, favState) {
                    return BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, searchState) {
                        if (searchState is SearchInitial) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 64.sp,
                                  color: Colors.white38,
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'Type a city name to search',
                                  style: AppTextStyle.bodyText14.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (searchState is SearchLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (searchState is SearchEmpty) {
                          return SearchEmptyWidget();
                        } else if (searchState is SearchError) {
                          return SearchErrorWidget();
                        } else if (searchState is SearchLoaded) {
                          Set<String> favoriteKeys = {};
                          if (favState is FavoritesLoadedState) {
                            favoriteKeys = favState.favoriteKeys;
                          }

                          return ListView.separated(
                            itemCount: searchState.results.length,
                            separatorBuilder: (_, __) => SizedBox(height: 8.h),
                            itemBuilder: (context, index) {
                              final loc = searchState.results[index];

                              final isFavorite = favoriteKeys.contains(key);

                              return WeatherCard(
                                location: '${loc.name}, ${loc.country}',
                                dateText:
                                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                temperature: '19°C',
                                condition: 'Rainy - cloudy',
                                wind: '26 km/h',
                                clouds: '2 of 10',
                                humidity: '100%',
                                assetImagePath: 'assets/images/rainy.png',

                                isFavorite: isFavorite,

                                onFavoriteTap: () {
                                  context.read<FavoritesCubit>().toggleFavorite(
                                    name: loc.name,
                                    country: loc.country,
                                    latitude: loc.lon,
                                    longitude: loc.lat,
                                  );
                                },

                                onCardTap: () {},
                              );
                            },
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
