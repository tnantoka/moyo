import 'dart:math';

import 'package:flutter_web/material.dart';

import 'maze_widget.dart';

class DungeonWidget extends StatelessWidget {
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
  final Random _random = Random();
  List<int> _dungeon = <int>[];

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

    const double dungeonLength = 11;
    const double mazeLength = dungeonLength * 3;
    final int mazeCountX = (width / mazeLength).floor();
    final int mazeCountY = (height / mazeLength).floor();
    final int dungeonCountX = mazeCountX * 3;
    final int dungeonCountY = mazeCountY * 3;

    if (_dungeon.isEmpty) {
      List<int> maze = buildMaze(mazeCountX, mazeCountY);
      _dungeon = _buildDungeon(
          maze, mazeCountX, mazeCountY, dungeonCountX, dungeonCountY);
    }

    for (int i = 0; i < dungeonCountY; i++) {
      final double y = i.toDouble() * dungeonLength + height % mazeLength * 0.5;
      for (int j = 0; j < dungeonCountX; j++) {
        final double x =
            j.toDouble() * dungeonLength + width % mazeLength * 0.5;
        final int m = _dungeon[i * dungeonCountX + j];
        canvas.drawRect(
          Rect.fromLTWH(x, y, dungeonLength, dungeonLength),
          m == 1 ? fill : stroke,
        );
      }
    }
  }

  List<int> _buildDungeon(List<int> maze, int mazeCountX, int mazeCountY,
      int dungeonCountX, int dungeonCountY) {
    final List<int> dungeon = List<int>.filled(
      dungeonCountX * dungeonCountY,
      1,
    );
    for (int i = 0; i < maze.length; i++) {
      if (maze[i] == 1) {
        continue;
      }
      final int x = i % mazeCountX;
      final int y = (i / mazeCountX).floor();
      if (_random.nextInt(5) == 0) {
        for (int j = 0; j < 3; j++) {
          for (int k = 0; k < 3; k++) {
            dungeon[(x * 3 + j) + (y * 3 + k) * dungeonCountX] = maze[i];
          }
        }
        continue;
      }
      dungeon[(x * 3 + 1) + (y * 3 + 1) * dungeonCountX] = maze[i];
      if (maze[i + 1] == 0) {
        dungeon[(x * 3 + 2) + (y * 3 + 1) * dungeonCountX] = maze[i];
      }
      if (maze[i - 1] == 0) {
        dungeon[(x * 3 + 0) + (y * 3 + 1) * dungeonCountX] = maze[i];
      }
      if (maze[i + mazeCountX] == 0) {
        dungeon[(x * 3 + 1) + (y * 3 + 2) * dungeonCountX] = maze[i];
      }
      if (maze[i - mazeCountX] == 0) {
        dungeon[(x * 3 + 1) + (y * 3 + 0) * dungeonCountX] = maze[i];
      }
    }
    return dungeon;
  }
}
