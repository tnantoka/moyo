import 'package:flutter_web/material.dart';

import 'circle.dart';
import 'square.dart';

void main() => runApp(MyApp());

String title = 'Moyo';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: MyHomePage(),
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
  ];

  Widget _buildBody() {
    switch (index) {
      case 0:
        return Circle();
        break;
      case 1:
        return Square();
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
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
