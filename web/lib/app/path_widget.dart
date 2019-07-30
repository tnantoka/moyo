import 'package:flutter_web/material.dart';

class PathWidget extends StatelessWidget {
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
    final Path path = Path();
    path.moveTo(-100, 100);
    path.conicTo(-100, -100, 100, -100, 1);
    path.conicTo(100, 100, -100, 100, 1);

    final Paint stroke = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final Paint fill = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawRect(const Rect.fromLTRB(-100, -100, 100, 100), stroke);
    canvas.drawPath(path, fill);
  }
}
