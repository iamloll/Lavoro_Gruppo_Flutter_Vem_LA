import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/screens/screen_selector/main_screen.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/states/saved_state.dart';

void main() {
  runApp(
    MultiProvider
    (providers: [
      ChangeNotifierProvider(create: (context)=> RecipeState()),
      ChangeNotifierProvider(create: (context) => SavedState())
    ],
    child:MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      // home : SearchRecipeForPlannerScreen()
    );
  }
}