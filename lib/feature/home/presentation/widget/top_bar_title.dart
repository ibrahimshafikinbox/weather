// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:weather_app/core/utils/styles/app_text_styles.dart';

// class TopBarTitle extends StatelessWidget {
//   final String title;
//   final VoidCallback? onAddTap;
//   final VoidCallback? onSettingsTap;
//   final Color color;

//   const TopBarTitle({
//     super.key,
//     required this.title,
//     this.onAddTap,
//     this.onSettingsTap,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         IconButton(
//           onPressed: onAddTap,
//           // ignore: deprecated_member_use
//           icon: Icon(Icons.add, size: 22.sp, color: color.withOpacity(0.85)),
//         ),
//         Expanded(
//           child: Center(
//             child: Text(
//               title,
//               style: AppTextStyle.bodyText18.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: color,
//               ),
//             ),
//           ),
//         ),
//         IconButton(
//           onPressed: onSettingsTap,
//           icon: Icon(
//             Icons.favorite_border_outlined,
//             size: 22.sp,
//             // ignore: deprecated_member_use
//             color: color.withOpacity(0.85),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/utils/styles/app_text_styles.dart';

class TopBarTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onAddTap;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;
  final Color color;

  const TopBarTitle({
    super.key,
    required this.title,
    this.onAddTap,
    this.onFavoriteTap,
    this.isFavorite = false,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // زر الإضافة (يسار)
        IconButton(
          onPressed: onAddTap,
          icon: Icon(Icons.add, size: 22.sp, color: color.withOpacity(0.85)),
        ),

        // العنوان (منتصف)
        Expanded(
          child: Center(
            child: Text(
              title,
              style: AppTextStyle.bodyText18.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ),

        // زر المفضلة (يمين)
        IconButton(
          onPressed: onFavoriteTap,
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
            size: 22.sp,
            color: isFavorite ? Colors.red : color.withOpacity(0.85),
          ),
        ),
      ],
    );
  }
}
