import 'package:flutter/material.dart' show IconData;

class HourlyEntry {
  final String hour;
  final int tempC;
  final double windKmh;
  final IconData icon;

  const HourlyEntry({
    required this.hour,
    required this.tempC,
    required this.windKmh,
    required this.icon,
  });
}
