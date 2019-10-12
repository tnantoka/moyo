import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'circle_spiral_widget.dart';
import 'circle_widget.dart';
import 'dungeon_widget.dart';
import 'fuyofuyo_widget.dart';
import 'grid_widget.dart';
import 'maze_widget.dart';
import 'path_widget.dart';
import 'shippo_widget.dart';
import 'square_widget.dart';
import 'turtle_graphics_widget.dart';

class PainterScreen extends StatefulWidget {
  const PainterScreen({Key key, this.path}) : super(key: key);

  final String path;

  static Map<String, String> widgets = Map<String, String>.fromEntries(
    <String>[
      'Blank',
      'Circle',
      'Square',
      'Path',
      'Shippo Tunagi',
      'Circle Spiral',
      'Fuyo Fuyo',
      'Grid',
      'Maze',
      'Dungeon',
      'Turtle Graphics',
    ].map(
      (String name) => MapEntry<String, String>(
        name.replaceAll(' ', '').toLowerCase(),
        name,
      ),
    ),
  );

  @override
  _PainterScreenState createState() => _PainterScreenState();
}

class _PainterScreenState extends State<PainterScreen> {
  GlobalKey globalKey = GlobalKey();

  bool _refreshing = false;

  Widget _buildBody() {
    if (_refreshing) {
      return Center(child: const CircularProgressIndicator());
    }
    switch (PainterScreen.widgets.keys.toList().indexOf(widget.path)) {
      case 1:
        return CircleWidget();
      case 2:
        return SquareWidget();
      case 3:
        return PathWidget();
      case 4:
        return ShippoWidget();
      case 5:
        return CircleSpiralWidget();
      case 6:
        return FuyoFuyoWidget();
      case 7:
        return GridWidget();
      case 8:
        return MazeWidget();
      case 9:
        return DungeonWidget();
      case 10:
        return TurtleGraphicsWidget();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(PainterScreen.widgets[widget.path]),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {
              setState(() {
                _refreshing = true;
              });
              Future<void>.delayed(const Duration(milliseconds: 500), () {
                setState(() {
                  _refreshing = false;
                });
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.save_alt),
            tooltip: 'Save',
            onPressed: () async {
              final RenderRepaintBoundary boundary =
                  globalKey.currentContext.findRenderObject();
              final ui.Image image = await boundary.toImage();
              final ByteData byteData =
                  await image.toByteData(format: ui.ImageByteFormat.png);
              final Uint8List pngBytes = byteData.buffer.asUint8List();
              final String base64 = base64Encode(pngBytes);

              final ClipboardData data =
                  ClipboardData(text: 'data:image/png;base64,$base64');
              await Clipboard.setData(data);

              showDialog<AlertDialog>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Copied'),
                    content:
                        const Text('It was saved to clipboard as dataURI.'),
                    actions: <Widget>[
                      FlatButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: RepaintBoundary(
        key: globalKey,
        child: _buildBody(),
      ),
    );
  }
}
