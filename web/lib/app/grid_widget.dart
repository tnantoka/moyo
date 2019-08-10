import 'package:flutter_web/material.dart';

class GridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            child: CustomPaint(
              painter: _MyPainter(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  _MyPainter({this.width, this.height});

  final double width;
  final double height;

  @override
  bool shouldRepaint(_MyPainter oldDelegate) {
    return oldDelegate.width != width || oldDelegate.height != height;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint stroke = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRect(Rect.fromLTRB(0, 0, width, height), stroke);

    const double length = 30;
    for (double x = 0; x < width; x += length) {
      for (double y = 0; y < height; y += length) {
        canvas.drawRect(
          Rect.fromLTWH(x, y, length, length),
          stroke,
        );
      }
    }
  }
}
