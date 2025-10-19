import 'package:flutter/material.dart' show IconData;

class ForecastEntry {
  final String day;
  final String label;
  final int highC;
  final int lowC;
  final IconData icon;

  const ForecastEntry({
    required this.day,
    required this.label,
    required this.highC,
    required this.lowC,
    required this.icon,
  });
}
