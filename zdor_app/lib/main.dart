import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/screens/home.dart';
import 'package:zdor_app/widgets/recipe_card.dart';
import 'package:zdor_app/screens/home.dart';
import 'package:zdor_app/widgets/main_screen.dart';
import 'package:zdor_app/widgets/recipe_detail/recipe_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
          // Definisci il tema della tua app
          ),
      home: MainScreen(), // Utilizza il MainScreen come schermata principale
    );
  }
}
