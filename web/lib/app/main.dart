import 'package:flutter_web/material.dart';

import 'circle_spiral_widget.dart';
import 'circle_widget.dart';
import 'fuyofuyo_widget.dart';
import 'grid_widget.dart';
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
  int index = 0;
  final List<String> _widgets = <String>[
    'Circle',
    'Square',
    'Path',
    'Shippo Tunagi',
    'Circle Spiral',
    'Fuyo Fuyo',
    'Grid',
  ];

  Widget _buildBody() {
    switch (index) {
      case 0:
        return CircleWidget();
      case 1:
        return SquareWidget();
      case 2:
        return PathWidget();
      case 3:
        return ShippoWidget();
      case 4:
        return CircleSpiralWidget();
      case 5:
        return FuyoFuyoWidget();
      case 6:
        return GridWidget();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Moyo - ${_widgets[index]}')),
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
                        index = i;
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
