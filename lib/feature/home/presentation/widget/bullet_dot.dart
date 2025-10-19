import 'package:flutter/material.dart';

class BulletDot extends StatelessWidget {
  final Color color;
  const BulletDot({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
