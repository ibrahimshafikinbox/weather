import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/utils/colors/app_colors.dart';
import 'package:weather_app/core/utils/styles/app_text_styles.dart';
import 'package:weather_app/feature/favorite/data/models/favorite_location_model.dart.dart';

class FavoriteWeatherCard extends StatelessWidget {
  final FavoriteLocationModel favoriteLocation;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const FavoriteWeatherCard({
    super.key,
    required this.favoriteLocation,
    required this.onRemove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MM/dd').format(favoriteLocation.addedAt);

    return Dismissible(
      key: Key(favoriteLocation.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      confirmDismiss: (direction) async {
        return await _showDismissDialog(context);
      },
      onDismissed: (direction) {
        onRemove();
      },
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.divider.withOpacity(0.4)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white.withOpacity(0.7),
                          size: 18.sp,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            favoriteLocation.name,
                            style: AppTextStyle.bodyText18.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      favoriteLocation.country,
                      style: AppTextStyle.bodyText14.copyWith(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 12.sp,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Added on $formattedDate',
                          style: AppTextStyle.bodyText12.copyWith(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  IconButton(
                    onPressed: onRemove,
                    icon: Icon(Icons.favorite, color: Colors.red, size: 28.sp),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _showDismissDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.scaffoldbg,
        title: Text('Remove Favorite', style: AppTextStyle.bodyText18),
        content: Text(
          'Remove ${favoriteLocation.name} from favorites?',
          style: AppTextStyle.bodyText14,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              'Cancel',
              style: AppTextStyle.bodyText14.copyWith(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
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
