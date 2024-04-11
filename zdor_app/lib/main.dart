import 'package:flutter/material.dart';
import 'package:zdor_app/screens/recipe_detail_screen.dart';
import 'package:zdor_app/screens/screen_selector/main_screen.dart';
//import 'package:zdor_app/screens/search_recipe_for_planner_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZdorApp',
      theme: ThemeData(
        // Definisco il tema scuro per l'app
        brightness: Brightness.dark,          
          ),
      // Utilizzo il MainScreen come schermata principale
      // Si occupa della navigazione tra le pagine
      home: const MainScreen(), 
      //home : SearchRecipeForPlannerScreen()
    );
  }
}