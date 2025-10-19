import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/utils/styles/app_text_styles.dart';
import 'package:weather_app/feature/home/presentation/cubit/weather_cubit.dart'
    show WeatherCubit;

class Weathererrorwidget extends StatelessWidget {
  const Weathererrorwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
          SizedBox(height: 16.h),
          Text('Error', style: AppTextStyle.bodyText16),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              "error loading weather",
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyText14,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () {
              context.read<WeatherCubit>().refreshWeather();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
