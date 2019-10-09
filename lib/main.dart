import 'dart:math';

import 'package:flutter/material.dart';

import 'painter_screen.dart';

void main() => runApp(MyApp());

String title = 'Moyo';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: MyHomePage(),
      theme: ThemeData(primaryColor: Colors.white),
      routes: PainterScreen.widgets.map(
        (String path, String name) => MapEntry<String, WidgetBuilder>(
          '/$path',
          (BuildContext context) => PainterScreen(path: path),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moyo'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shuffle),
            tooltip: 'Shuffle',
            onPressed: () {
              setState(() {
                final int index = _random.nextInt(PainterScreen.widgets.length);
                Navigator.pushNamed(
                  context,
                  '/${PainterScreen.widgets.keys.toList()[index]}',
                );
              });
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children:
            PainterScreen.widgets.entries.map((MapEntry<String, String> entry) {
          return ListTile(
            title: Text(entry.value),
            onTap: () {
              Navigator.pushNamed(context, '/${entry.key}');
            },
          );
        }).toList(),
      ),
    );
  }
}
