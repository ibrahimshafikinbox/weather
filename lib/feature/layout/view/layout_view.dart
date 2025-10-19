import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/colors/app_colors.dart';
import 'package:weather_app/feature/favorite/presentation/view/favorite_view.dart';
import 'package:weather_app/feature/home/presentation/view/home_view.dart';
import 'package:weather_app/feature/layout/Widgets/custom_bottom_nav_bar.dart';
import 'package:weather_app/feature/layout/cubit/layout_cubit.dart';
import 'package:weather_app/feature/search/presentation/view/search_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, index) {
          return Scaffold(
            backgroundColor: AppColors.scaffoldbg,
            body: _getPage(index),
            bottomNavigationBar: CustomBottomBar(
              selectedIndex: index,
              onItemTapped: (i) =>
                  context.read<BottomNavCubit>().updateIndex(i),
              onCenterTapped: () {
                context.read<BottomNavCubit>().updateIndex(1);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const SearchView();
      case 2:
        return const FavoriteView();
      default:
        return const Scaffold();
    }
  }
}
