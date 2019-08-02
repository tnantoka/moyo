import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

class ShippoWidget extends StatelessWidget {
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
    const double length = 30;
    const int count = 10;
    for (int i = 0; i < count; i++) {
      final double x = -150 + i.toDouble() * length;
      for (int j = 0; j < count; j++) {
        final double y = -150 + j.toDouble() * length;
        double rotation;
        if (j % 2 == 0) {
          rotation = i % 2 == 0 ? 0 : 90;
        } else {
          rotation = i % 2 == 0 ? 270 : 180;
        }
        leaf(canvas, x, y, length, rotation);
      }
    }
  }

  void leaf(Canvas canvas, double x, double y, double length, double rotation) {
    final double radius = length * 0.5;

    canvas.save();
    canvas.translate(x + radius, y + radius);
    canvas.rotate(radians(rotation));

    final Path path = Path();
    path.moveTo(-radius, -radius + length);
    path.conicTo(-radius, -radius, -radius + length, -radius, 0.7);
    path.conicTo(
        -radius + length, -radius + length, -radius, -radius + length, 0.7);

    final Paint fill = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fill);

    canvas.restore();
  }
}
