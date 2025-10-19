// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:weather_app/core/utils/colors/app_colors.dart';
// import 'package:weather_app/core/utils/styles/app_text_styles.dart';
// import 'package:weather_app/feature/search/data/models/location_model.dart';
// import 'package:weather_app/feature/search/presentation/widget/weather_info_item.dart';

// class WeatherCard extends StatelessWidget {
//   final String location;
//   final String dateText;
//   final String temperature;
//   final String condition;
//   final String wind;
//   final String clouds;
//   final String humidity;
//   final String assetImagePath;

//   const WeatherCard({
//     Key? key,
//     required this.location,
//     required this.dateText,
//     required this.temperature,
//     required this.condition,
//     required this.wind,
//     required this.clouds,
//     required this.humidity,
//     required this.assetImagePath,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(18.w),
//       decoration: BoxDecoration(
//         border: Border.all(
//           // ignore: deprecated_member_use
//           color: AppColors.white.withOpacity(0.35),
//           width: 1.2.w,
//         ),
//         color: AppColors.scaffoldbg,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             // ignore: deprecated_member_use
//             color: Colors.black.withOpacity(0.25),
//             blurRadius: 10.r,
//             offset: Offset(0, 6.h),
//           ),
//         ],
//       ),
//       constraints: BoxConstraints(maxWidth: 360.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.location_on_outlined,
//                           color: AppColors.white,
//                           size: 18.sp,
//                         ),
//                         SizedBox(width: 6.w),
//                         Flexible(
//                           child: Text(
//                             location,
//                             style: AppTextStyle.bodyText18,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 6.h),
//                     Text(
//                       dateText,
//                       style: AppTextStyle.bodyText14.copyWith(
//                         color: AppColors.white.withOpacity(0.75),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(
//                 width: 92.w,
//                 height: 72.h,
//                 child: Image.asset(assetImagePath, fit: BoxFit.contain),
//               ),
//             ],
//           ),

//           SizedBox(height: 15.h),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Text(condition, style: AppTextStyle.bodyText14.copyWith()),
//             ],
//           ),

//           SizedBox(height: 14.h),

//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 temperature,
//                 style: AppTextStyle.bodyText30.copyWith(color: AppColors.white),
//               ),

//               SizedBox(width: 16.w),

//               Expanded(
//                 child: Wrap(
//                   spacing: 12.w,
//                   runSpacing: 8.h,
//                   crossAxisAlignment: WrapCrossAlignment.center,
//                   children: [
//                     WeatherInfoItem(icon: Icons.air, label: wind),
//                     WeatherInfoItem(icon: Icons.cloud_outlined, label: clouds),
//                     WeatherInfoItem(
//                       icon: Icons.water_drop_outlined,
//                       label: humidity,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
// // lib/feature/search/presentation/widget/search_result_tile.dart

// class SearchResultTile extends StatelessWidget {
//   final LocationModel location;
//   final VoidCallback? onTap;

//   const SearchResultTile({super.key, required this.location, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final title =
//         '${location.name}, ${location.region.isNotEmpty ? '${location.region}, ' : ''}${location.country}';
//     final subtitle = 'Lat: ${location.lat}, Lon: ${location.lon}';
//     return ListTile(
//       onTap: onTap,
//       leading: Icon(Icons.location_on_outlined, color: AppColors.white),
//       title: Text(title, style: AppTextStyle.bodyText16),
//       subtitle: Text(
//         subtitle,
//         style: AppTextStyle.bodyText14.copyWith(
//           color: AppColors.white.withOpacity(0.7),
//         ),
//       ),
//       trailing: const Icon(Icons.chevron_right, color: Colors.white),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/utils/styles/app_text_styles.dart';

class WeatherCard extends StatelessWidget {
  final String location;
  final String dateText;
  final String temperature;
  final String condition;
  final String wind;
  final String clouds;
  final String humidity;
  final String assetImagePath;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onCardTap;

  const WeatherCard({
    super.key,
    required this.location,
    required this.dateText,
    required this.temperature,
    required this.condition,
    required this.wind,
    required this.clouds,
    required this.humidity,
    required this.assetImagePath,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // ignore: deprecated_member_use
              Colors.blue.shade300.withOpacity(0.3),
              Colors.purple.shade300.withOpacity(0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========== Header: الموقع + زر المفضلة ==========
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location,
                        style: AppTextStyle.bodyText16.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        dateText,
                        style: AppTextStyle.bodyText12.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                // ✅ زر المفضلة
                IconButton(
                  onPressed: onFavoriteTap,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white70,
                    size: 24.sp,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // ========== Body: الطقس ==========
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الأيقونة
                Image.asset(
                  assetImagePath,
                  width: 80.w,
                  height: 80.h,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.cloud,
                      size: 80.sp,
                      color: Colors.white54,
                    );
                  },
                ),

                SizedBox(width: 16.w),

                // المعلومات
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // درجة الحرارة
                      Text(
                        temperature,
                        style: AppTextStyle.bodyText24.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),

                      // الحالة
                      Text(
                        condition,
                        style: AppTextStyle.bodyText14.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // التفاصيل
                      _buildDetailRow(Icons.air, 'Wind: $wind'),
                      SizedBox(height: 4.h),
                      _buildDetailRow(Icons.cloud, 'Clouds: $clouds'),
                      SizedBox(height: 4.h),
                      _buildDetailRow(Icons.water_drop, 'Humidity: $humidity'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: Colors.white60),
        SizedBox(width: 6.w),
        Text(
          text,
          style: AppTextStyle.bodyText12.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}
