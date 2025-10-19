import 'dart:ui' show Canvas, Size, Path, Paint, PaintingStyle;

import 'package:flutter/widgets.dart' show CustomPainter, Color;

class TempLinePainter extends CustomPainter {
  final List<double> temps;
  final Color lineColor;

  TempLinePainter({required this.temps, required this.lineColor});

  @override
  void paint(Canvas canvas, Size size) {
    if (temps.length < 2) return;

    final minT = temps.reduce((a, b) => a < b ? a : b);
    final maxT = temps.reduce((a, b) => a > b ? a : b);
    final range = (maxT - minT).clamp(1, double.infinity);

    final path = Path();
    final stepX = size.width / (temps.length - 1);

    for (int i = 0; i < temps.length; i++) {
      final x = i * stepX;
      final norm = (temps[i] - minT) / range;
      final y = size.height - norm * size.height * 0.8;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final paint = Paint()
      ..color = lineColor.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant TempLinePainter old) {
    return old.temps != temps || old.lineColor != lineColor;
  }
}
