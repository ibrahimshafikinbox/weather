import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
        color: const Color(0xFF7392c0),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: child,
    );
  }
}
