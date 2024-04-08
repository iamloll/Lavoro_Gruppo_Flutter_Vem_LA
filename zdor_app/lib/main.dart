import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/screens/home.dart';
import 'package:zdor_app/widgets/recipe_card.dart';
import 'package:zdor_app/screens/home.dart';
import 'package:zdor_app/widgets/main_screen.dart';
import 'package:zdor_app/screens/recipe_detail_screen.dart';
import 'package:zdor_app/widgets/style/constant.dart';

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
          // textTheme: TextTheme(
          //   bodySmall : TextStyle(color: kWhiteColor)
          // ),
        ),
      //home: MainScreen(), // Utilizza il MainScreen come schermata principale
      home: RecipeDetailScreen()
    );
  }
}
