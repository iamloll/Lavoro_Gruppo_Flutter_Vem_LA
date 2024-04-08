
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/screens/search_recipe_for_planner_screen.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'screens/planner_screen.dart';

void main() {
  //QUI VA IL COMPONENTE BASE DA VISUALIZZARE NELL'APP
  runApp(
     MaterialApp(
      //elimino il flag debug in alto a destra
      debugShowCheckedModeBanner: false,
      /* dark theme settings */
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: ChangeNotifierProvider(
        create: (BuildContext context) => RecipeState() ,
        child: SafeArea(
          child: SearchRecipeForPlannerScreen()
        ),
      ),
    ));
}

