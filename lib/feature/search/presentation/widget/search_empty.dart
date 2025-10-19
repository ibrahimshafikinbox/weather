import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/utils/styles/app_text_styles.dart';

class SearchEmptyWidget extends StatelessWidget {
  const SearchEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_off, size: 64.sp, color: Colors.white38),
          SizedBox(height: 16.h),
          Text(
            'No results found',
            style: AppTextStyle.bodyText14.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
