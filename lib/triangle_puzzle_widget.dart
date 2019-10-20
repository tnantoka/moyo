import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_shapes/flutter_shapes.dart';

class TrianglePuzzleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CustomPaint(painter: _MyPainter()),
      ),
    );
  }
}

final Random _rand = Random();
Paint _randomFill() {
  return Paint()
    ..color = Color.fromRGBO(
        _rand.nextInt(255), _rand.nextInt(255), _rand.nextInt(255), 1.0)
    ..style = PaintingStyle.fill;
}

class _MyPainter extends CustomPainter {
  @override
  bool shouldRepaint(_MyPainter oldDelegate) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint stroke = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const double radius = 30;

    final Shapes shapes = Shapes(
      canvas: canvas,
      radius: radius,
    );

    for (int i = -2; i < 4; i++) {
      final double baseX = i % 2 == 0 ? 0 : radius * 0.88;

      for (int j = -2; j < (i % 2 == 0 ? 3 : 2); j++) {
        shapes
          ..center = Offset(baseX + j.toDouble() * radius * 1.76,
              i.toDouble() * radius * 1.54)
          ..angle = 0;
        (shapes..paint = _randomFill()).drawType(ShapeType.Triangle);
        (shapes..paint = stroke).drawType(ShapeType.Triangle);
      }

      for (int j = i % 2 == 0 ? -1 : -2; j < 3; j++) {
        shapes
          ..center = Offset(
              baseX + j.toDouble() * radius * 1.76 - radius * 0.88,
              i.toDouble() * radius * 1.54 - radius * 0.52)
          ..angle = radians(60);
        (shapes..paint = _randomFill()).drawType(ShapeType.Triangle);
        (shapes..paint = stroke).drawType(ShapeType.Triangle);
      }
    }
  }
}
