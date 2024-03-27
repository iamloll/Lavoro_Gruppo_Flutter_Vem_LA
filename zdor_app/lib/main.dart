import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';

import 'widgets/recipe_detail_screen.dart';
//import 'package:get/get.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SafeArea(child: HomeScreen()),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZdorApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const RecipeDetailScreen(),
    );
  }
}