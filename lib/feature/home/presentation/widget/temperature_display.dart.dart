import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/utils/styles/app_text_styles.dart';

class TemperatureDisplay extends StatelessWidget {
  final int temperatureC;
  final String unit;
  final Color color;

  const TemperatureDisplay({
    super.key,
    required this.temperatureC,
    this.unit = '°C',
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$temperatureC',
          style: AppTextStyle.bodyText30.copyWith(
            fontSize: 120.sp,
            height: 1,
            fontWeight: FontWeight.w300,
            color: color,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h, left: 4.w),
          child: Text(
            unit,
            style: AppTextStyle.bodyText22.copyWith(
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
