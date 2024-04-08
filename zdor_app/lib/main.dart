import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/screens/home.dart';
import 'package:zdor_app/widgets/recipe_card.dart';
import 'package:zdor_app/screens/home.dart';
import 'package:zdor_app/widgets/main_screen.dart';

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



// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: SafeArea(child: HomeScreen()),
//   ));
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'ZdorApp',
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//       ),
//       home: const RecipeDetailScreen(),
