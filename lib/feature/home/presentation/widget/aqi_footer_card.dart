// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/utils/styles/app_text_styles.dart';
import 'package:weather_app/feature/home/presentation/widget/custom_glass_card.dart';
import 'aqi_pill.dart';

class AqiFooterCard extends StatelessWidget {
  final int aqi;
  final Color onTextColor;
  final Color primary;
  final VoidCallback? onTapDetails;

  const AqiFooterCard({
    super.key,
    required this.aqi,
    required this.onTextColor,
    required this.primary,
    this.onTapDetails,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(Icons.blur_on, color: AqiPill.aqiColor(aqi), size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              'AQI $aqi',
              style: AppTextStyle.bodyText14.copyWith(
                color: onTextColor.withOpacity(0.85),
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: onTapDetails,
              borderRadius: BorderRadius.circular(8.r),
              child: Row(
                children: [
                  Text(
                    'Full air quality forecast',
                    style: AppTextStyle.bodyText12.copyWith(
                      color: primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.chevron_right, size: 18.sp, color: primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
