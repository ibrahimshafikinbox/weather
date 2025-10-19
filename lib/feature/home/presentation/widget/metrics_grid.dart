import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/utils/styles/app_text_styles.dart';
import 'package:weather_app/feature/home/presentation/widget/custom_glass_card.dart';

class MetricsGrid extends StatelessWidget {
  final Color onTextColor;
  final Color primary;
  final String windDirection;
  final double windSpeedKmh;
  final int humidity;
  final int realFeel;
  final int uvIndex;
  final String sunrise;
  final String sunset;
  final int pressureMbar;
  final int chanceOfRainPct;

  const MetricsGrid({
    super.key,
    required this.onTextColor,
    required this.primary,
    required this.windDirection,
    required this.windSpeedKmh,
    required this.humidity,
    required this.realFeel,
    required this.uvIndex,
    required this.sunrise,
    required this.sunset,
    required this.pressureMbar,
    required this.chanceOfRainPct,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 86.h,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
      ),
      children: [
        _MetricCard(
          onText: onTextColor,
          child: Row(
            children: [
              Icon(Icons.explore_outlined, color: primary, size: 28.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      windDirection,
                      style: AppTextStyle.bodyText14.copyWith(
                        color: onTextColor.withOpacity(0.85),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${windSpeedKmh.toStringAsFixed(1)}km/h',
                      style: AppTextStyle.bodyText12.copyWith(
                        color: onTextColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _MetricCard(
          onText: onTextColor,
          child: _twoLine('Humidity', '$humidity%', onTextColor),
        ),
        _MetricCard(
          onText: onTextColor,
          child: _twoLine('Real feel', '$realFeel°', onTextColor),
        ),
        _MetricCard(
          onText: onTextColor,
          child: _twoLine('UV', '$uvIndex', onTextColor),
        ),
        _MetricCard(
          onText: onTextColor,
          child: Row(
            children: [
              Icon(Icons.wb_twilight, color: primary, size: 26.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sunrise',
                      style: AppTextStyle.bodyText12.copyWith(
                        color: onTextColor.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      sunrise,
                      style: AppTextStyle.bodyText14.copyWith(
                        color: onTextColor.withOpacity(0.85),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sunset',
                    style: AppTextStyle.bodyText12.copyWith(
                      color: onTextColor.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    sunset,
                    style: AppTextStyle.bodyText14.copyWith(
                      color: onTextColor.withOpacity(0.85),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        _MetricCard(
          onText: onTextColor,
          child: _twoLine('Pressure', '${pressureMbar}mbar', onTextColor),
        ),
        _MetricCard(
          onText: onTextColor,
          child: _twoLine('Chance of rain', '$chanceOfRainPct%', onTextColor),
        ),
      ],
    );
  }

  Widget _twoLine(String title, String value, Color color) {
    return Row(
      children: [
        Icon(Icons.lens, size: 8.r, color: color.withOpacity(0.6)),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle.bodyText12.copyWith(
                  color: color.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: AppTextStyle.bodyText14.copyWith(
                  color: color.withOpacity(0.85),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final Widget child;
  final Color onText;

  const _MetricCard({required this.child, required this.onText});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: child,
      ),
    );
  }
}
