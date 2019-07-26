import 'package:flutter/material.dart';

import 'widget1.dart';
import 'widget2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moyo',
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
    'Widget1',
    'Widget2',
  ];

  Widget _buildBody() {
    switch (index) {
      case 0:
        return Widget1();
        break;
      case 1:
        return Widget2();
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('test')),
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
