import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/utils/styles/app_text_styles.dart';
import 'package:weather_app/feature/home/data/hourly_entry_model.dart';
import 'package:weather_app/feature/home/presentation/widget/custom_glass_card.dart';
import 'package:weather_app/feature/home/presentation/widget/temp_line_painter.dart';

class HourlyForecastCard extends StatelessWidget {
  final List<HourlyEntry> items;
  final Color onTextColor;
  final Color primary;

  const HourlyForecastCard({
    super.key,
    required this.items,
    required this.onTextColor,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Text(
                '24-hour forecast',
                style: AppTextStyle.bodyText16.copyWith(
                  color: onTextColor.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 140.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: TempLinePainter(
                          temps: items.map((e) => e.tempC.toDouble()).toList(),
                          lineColor: primary,
                        ),
                      ),
                    ),
                    ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (_, i) {
                        final it = items[i];
                        return Container(
                          width: 75.w,
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                it.icon,
                                size: 28.sp,
                                color: onTextColor.withOpacity(0.9),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                '${it.tempC}°',
                                style: AppTextStyle.bodyText14.copyWith(
                                  color: onTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '${it.windKmh.toStringAsFixed(1)} km/h',
                                style: AppTextStyle.bodyText12.copyWith(
                                  color: onTextColor.withOpacity(0.7),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                it.hour,
                                style: AppTextStyle.bodyText12.copyWith(
                                  color: onTextColor.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(width: 6.w),
                      itemCount: items.length,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
