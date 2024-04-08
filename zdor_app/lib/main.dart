import 'package:flutter/material.dart';
import 'package:zdor_app/screens/planner_screen.dart';
import 'package:zdor_app/widgets/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        brightness: Brightness.dark,
          // Definisci il tema della tua app
          ),
      home: const MainScreen(), // Utilizza il MainScreen come schermata principale
    );
  }
}