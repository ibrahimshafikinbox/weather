import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/feature/favorite/data/models/favorite_location_model.dart.dart';
import 'package:weather_app/feature/favorite/presentation/widget/fav_card.dart';
import '../../../../core/helper/assets/assets_helper.dart';
import '../../../../core/utils/colors/app_colors.dart';
import '../../../../core/utils/styles/app_text_styles.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoritesCubit(repository: context.read())..loadFavorites(),
      child: const _FavoriteViewContent(),
    );
  }
}

class _FavoriteViewContent extends StatelessWidget {
  const _FavoriteViewContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldbg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Favorite Cities", style: AppTextStyle.bodyText18),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  if (state is FavoritesLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is FavoritesErrorState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64.sp,
                            color: Colors.red,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Error loading favorites',
                            style: AppTextStyle.bodyText18,
                          ),
                          SizedBox(height: 8.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.w),
                            child: Text(
                              state.errorMessage,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.bodyText14.copyWith(
                                color: Colors.red.shade300,
                              ),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.read<FavoritesCubit>().loadFavorites();
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is FavoritesLoadedState) {
                    if (state.favorites.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 80.sp,
                              color: Colors.grey.shade400,
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              'No favorites yet',
                              style: AppTextStyle.bodyText18.copyWith(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'Add locations to your favorites to see them here',
                              textAlign: TextAlign.center,
                              style: AppTextStyle.bodyText14.copyWith(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        await context.read<FavoritesCubit>().loadFavorites();
                      },
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        itemCount: state.favorites.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        itemBuilder: (context, index) {
                          final favorite = state.favorites[index];
                          return FavoriteWeatherCard(
                            favoriteLocation: favorite,
                            onRemove: () {
                              _removeFavorite(
                                context,
                                favorite.id!,
                                favorite.name,
                              );
                            },
                            onTap: () {},
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeFavorite(BuildContext context, int id, String locationName) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.scaffoldbg,
        title: Text('Remove Favorite', style: AppTextStyle.bodyText18),
        content: Text(
          'Remove $locationName from favorites?',
          style: AppTextStyle.bodyText14,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: AppTextStyle.bodyText14.copyWith(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              // Use the context from the builder to access the cubit
              context.read<FavoritesCubit>().removeFavorite(id);
              Navigator.of(dialogContext).pop();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$locationName removed from favorites'),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red.shade700,
                ),
              );
            },
            child: Text(
              'Remove',
              style: AppTextStyle.bodyText14.copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
