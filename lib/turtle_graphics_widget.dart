import 'dart:async';
//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

class TurtleGraphicsWidget extends StatefulWidget {
  @override
  _TurtleGraphicsWidgetState createState() => _TurtleGraphicsWidgetState();
}

class _TurtleGraphicsWidgetState extends State<TurtleGraphicsWidget>
    with SingleTickerProviderStateMixin {
  int _commandIndex = 0;
  Timer _timer;
  List<Command> _commands;
//  final Random _rand = Random();

  @override
  void initState() {
    super.initState();

    _commands = <Command>[];
//    final int numberOfCommands = _rand.nextInt(50) + 30;
//    print(numberOfCommands);
//    for (int i = 0; i < numberOfCommands; i++) {
//      final bool isForward = _rand.nextInt(5) == 0;
//      final Command command = Command(
//        type: isForward ? CommandType.forward : CommandType.rotate,
//        value: isForward
//            ? _rand.nextDouble() * 100 + 10
//            : _rand.nextDouble() * 360,
//      );
//      _commands.add(command);
//    }

    for (int i = 0; i < 6; i++) {
      _commands.add(Command(type: CommandType.rotate, value: 60));
      _commands.add(Command(type: CommandType.forward, value: 80));
    }

    for (int i = 0; i < 8; i++) {
      _commands.add(Command(type: CommandType.rotate, value: -45));
      _commands.add(Command(type: CommandType.forward, value: 50));
    }

    _timer = Timer.periodic(
      Duration(milliseconds: 100),
      (Timer timer) => setState(
        () {
          if (_commandIndex >= _commands.length) {
            timer.cancel();
          } else {
            _commandIndex++;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CustomPaint(
          painter: _MyPainter(commands: _commands, commandIndex: _commandIndex),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class _MyPainter extends CustomPainter {
  _MyPainter({this.commands, this.commandIndex});

  final List<Command> commands;
  final int commandIndex;

  @override
  bool shouldRepaint(_MyPainter oldDelegate) {
    return oldDelegate.commandIndex != commandIndex;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint stroke = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Offset lastPoint = Offset(
      size.width * 0.5,
      size.height * 0.5,
    );
    for (int i = 0; i < commandIndex; i += 1) {
      final Command command = commands[i];
      Offset point;
      switch (command.type) {
        case CommandType.forward:
          point = lastPoint.translate(0.0, command.value);
          break;
        case CommandType.rotate:
          canvas.translate(lastPoint.dx, lastPoint.dy);
          canvas.rotate(radians(command.value));
          canvas.translate(-lastPoint.dx, -lastPoint.dy);
          break;
      }
      if (point != null) {
        canvas.drawLine(lastPoint, point, stroke);
        lastPoint = point;
      }
    }

    canvas.drawCircle(lastPoint, 10, stroke);
  }
}

enum CommandType { forward, rotate }

class Command {
  Command({this.type, this.value});

  final CommandType type;
  final double value;
}
