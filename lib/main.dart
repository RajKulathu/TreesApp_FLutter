import 'package:flutter/material.dart';
import './Index.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        routes: {
          '/': (context) => TreesHomeScreen(),
        },
      );
  }
}
