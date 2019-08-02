import 'dart:math';

import 'package:flutter_web/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

class CircleSpiralWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CustomPaint(painter: _MyPainter()),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  bool shouldRepaint(_MyPainter oldDelegate) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    const double radius = 100;

    final Paint fill = Paint()
      ..color = Colors.black.withAlpha(20)
      ..style = PaintingStyle.fill;
    final Paint stroke = Paint()
      ..color = Colors.black.withAlpha(40)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < 360; i += 15) {
      final double rotation = radians(i.toDouble());
      final double x = radius * cos(rotation);
      final double y = radius * sin(rotation);

      canvas.drawCircle(Offset(x, y), radius * 0.7, fill);
      canvas.drawCircle(Offset(x, y), radius * 0.7, stroke);
    }
  }
}
