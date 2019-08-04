import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

class FuyoFuyoWidget extends StatefulWidget {
  @override
  _FuyoFuyoWidgetState createState() => _FuyoFuyoWidgetState();
}

class _FuyoFuyoWidgetState extends State<FuyoFuyoWidget>
    with SingleTickerProviderStateMixin {
  double _amplitude = 15;
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _animation = Tween<double>(begin: 15.0, end: -15.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _amplitude = _animation.value;
        });
      });

    return Container(
      child: Center(
        child: CustomPaint(
          painter: _MyPainter(
            amplitude: _amplitude,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _MyPainter extends CustomPainter {
  _MyPainter({this.amplitude});

  final double amplitude;

  @override
  bool shouldRepaint(_MyPainter oldDelegate) {
    return oldDelegate.amplitude != amplitude;
  }

  @override
  void paint(Canvas canvas, Size size) {
    const double radius = 100;
    const double frequency = 10;

    final Paint stroke = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Offset lastPoint;
    for (int i = 0; i <= 360; i += 1) {
      final double angle = radians(i.toDouble());
      // final double x = radius * cos(angle);
      // final double y = radius * sin(angle);
      final double noise = sin(angle * frequency) * amplitude;
      final double x = (radius + noise) * cos(angle);
      final double y = (radius + noise) * sin(angle);

      final Offset point = Offset(x, y);
      if (lastPoint != null) {
        canvas.drawLine(lastPoint, point, stroke);
      }
      lastPoint = point;
    }
  }
}
