import 'dart:math';

import 'package:flutter/material.dart';

class MazeWidget extends StatelessWidget {
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
  List<int> _maze = <int>[];

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
    final Paint fill = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTRB(0, 0, width, height), stroke);

    const double length = 33;
    final int countX = (width / length).floor();
    final int countY = (height / length).floor();

    if (_maze.isEmpty) {
      _maze = buildMaze(countX, countY);
    }

    for (int i = 0; i < countY; i++) {
      final double y = i.toDouble() * length + height % length * 0.5;
      for (int j = 0; j < countX; j++) {
        final double x = j.toDouble() * length + width % length * 0.5;
        final int m = _maze[i * countX + j];
        canvas.drawRect(
          Rect.fromLTWH(x, y, length, length),
          m == 1 ? fill : stroke,
        );
      }
    }
  }
}

final Random _random = Random();
List<int> buildMaze(int countX, int countY) {
  final List<int> maze = List<int>.filled(countX * countY, 0);
  for (int i = 0; i < maze.length; i++) {
    final int x = i % countX;
    final int y = (i / countX).floor();
    final bool isWall = x == 0 || y == 0 || x == countX - 1 || y == countY - 1;
    final bool isPillar = x.isEven &&
        y.isEven &&
        x > 1 &&
        y > 1 &&
        x < countX - 1 &&
        y < countY - 1;
    if (isWall || isPillar) {
      maze[i] = 1;
    }
    if (isPillar) {
      switch (_random.nextInt(4)) {
        case 0:
          maze[i + 1] = 1;
          break;
        case 1:
          maze[i + 1] = 1;
          break;
        case 2:
          maze[i + countX] = 1;
          break;
        default:
          maze[i - countX] = 1;
      }
    }
  }
  return maze;
}
