import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/styles/app_text_styles.dart';

class ConditionAndRangeText extends StatelessWidget {
  final String condition;
  final int highC;
  final int lowC;
  final Color color;

  const ConditionAndRangeText({
    super.key,
    required this.condition,
    required this.highC,
    required this.lowC,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$condition   $highC° / $lowC°',
          style: AppTextStyle.bodyText16.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
