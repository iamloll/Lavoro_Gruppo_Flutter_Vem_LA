import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:zdor_app/screens/screen_selector/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
          ),
      home: MainScreen(),
    );
  }
}
