import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zdor_app/screens/lista_spesa_screen.dart';
import 'package:zdor_app/screens/screen_selector/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(),
      home: IngredientListScreen(),
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
