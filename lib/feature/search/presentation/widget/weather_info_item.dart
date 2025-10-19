import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/utils/colors/app_colors.dart';
import 'package:weather_app/core/utils/styles/app_text_styles.dart';

class WeatherInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const WeatherInfoItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.white.withOpacity(0.95), size: 14.sp),
        SizedBox(width: 6.w),
        Text(
          label,
          style: AppTextStyle.bodyText14.copyWith(
            color: AppColors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}
