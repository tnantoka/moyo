import 'dart:math';

import 'package:flutter/material.dart';

import 'circle_spiral_widget.dart';
import 'circle_widget.dart';
import 'fuyofuyo_widget.dart';
import 'grid_widget.dart';
import 'maze_widget.dart';
import 'path_widget.dart';
import 'shippo_widget.dart';
import 'square_widget.dart';

void main() => runApp(MyApp());

String title = 'Moyo';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: MyHomePage(),
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 1;
  bool _refreshing = false;
  final List<String> _widgets = <String>[
    'Blank',
    'Circle',
    'Square',
    'Path',
    'Shippo Tunagi',
    'Circle Spiral',
    'Fuyo Fuyo',
    'Grid',
    'Maze',
  ];
  final Random _random = Random();

  Widget _buildBody() {
    if (_refreshing) {
      return Center(child: const CircularProgressIndicator());
    }
    switch (_index) {
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
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moyo - ${_widgets[_index]}'),
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
            icon: const Icon(Icons.shuffle),
            tooltip: 'Shuffle',
            onPressed: () {
              setState(() {
                _index = _random.nextInt(_widgets.length);
              });
            },
          ),
        ],
      ),
      body: _buildBody(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: _widgets
              .asMap()
              .map((int i, String widget) {
                return MapEntry<int, ListTile>(
                  i,
                  ListTile(
                    title: Text(widget),
                    onTap: () {
                      setState(() {
                        _index = i;
                      });
                      Navigator.pop(context);
                    },
                  ),
                );
              })
              .values
              .toList(),
        ),
      ),
    );
  }
}
