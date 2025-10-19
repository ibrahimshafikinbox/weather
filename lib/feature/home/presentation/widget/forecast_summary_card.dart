import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/utils/colors/app_colors.dart';
import 'package:weather_app/core/utils/styles/app_text_styles.dart';
import 'package:weather_app/feature/home/data/forcast_entry_model.dart';
import 'package:weather_app/feature/home/presentation/widget/custom_glass_card.dart';

class ForecastSummaryCard extends StatelessWidget {
  final String headerTitle;
  final String headerActionText;
  final List<ForecastEntry> items;
  final VoidCallback? onActionTap;
  final Color onTextColor;
  final Color primary;

  const ForecastSummaryCard({
    super.key,
    required this.headerTitle,
    required this.headerActionText,
    required this.items,
    this.onActionTap,
    required this.onTextColor,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              children: [
                Text(
                  headerTitle,
                  style: AppTextStyle.bodyText16.copyWith(
                    color: Colors.grey.shade300,

                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: onActionTap,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        headerActionText,
                        style: AppTextStyle.bodyText12.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 18.sp,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            child: Column(
              children: items
                  .map(
                    (e) => _ForecastRow(
                      item: e,
                      textColor: onTextColor,
                      primary: primary,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ForecastRow extends StatelessWidget {
  final ForecastEntry item;
  final Color textColor;
  final Color primary;

  const _ForecastRow({
    required this.item,
    required this.textColor,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(item.icon, size: 18.sp, color: textColor.withOpacity(0.7)),

          SizedBox(width: 10.w),
          SizedBox(
            width: 40.w,
            child: Text(
              item.day,
              style: AppTextStyle.bodyText14.copyWith(
                fontWeight: FontWeight.w600,
                color: textColor.withOpacity(0.85),
              ),
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              item.label,
              style: AppTextStyle.bodyText14.copyWith(
                color: textColor.withOpacity(0.7),
              ),
            ),
          ),
          Text(
            '${item.highC}° / ${item.lowC}°',
            style: AppTextStyle.bodyText14.copyWith(
              fontWeight: FontWeight.w600,
              color: textColor.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}
