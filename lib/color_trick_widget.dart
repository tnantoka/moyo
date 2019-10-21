import 'package:flutter/material.dart';

import 'package:flutter_shapes/flutter_shapes.dart';

class ColorTrickWidget extends StatelessWidget {
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
    final Paint fillRed = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red;
    final Paint fillGreen = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.green;
    final Paint fillYellow = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.yellow;

    _drawStar(canvas, -75, <Paint>[fillRed, fillGreen, fillYellow]);
    _drawStar(canvas, 75, <Paint>[fillRed, fillYellow, fillGreen]);
  }

  void _drawStar(Canvas canvas, double baseX, List<Paint> paints) {
    for (int i = 0; i < 8; i++) {
      canvas.drawRect(
          Rect.fromLTWH(baseX - 65, -66 + i.toDouble() * 16, 130, 8),
          paints[1]);
    }
    Shapes(
      canvas: canvas,
      radius: 60,
      paint: paints[0],
      center: Offset(baseX, 0),
    ).drawType(ShapeType.Star5);
    for (int i = 0; i < 8; i++) {
      canvas.drawRect(
          Rect.fromLTWH(baseX - 65, -58 + i.toDouble() * 16, 130, 8),
          paints[2]);
    }
  }
}
