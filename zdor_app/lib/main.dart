
import 'package:flutter/material.dart';

import 'widgets/planner_widget.dart';

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
      home: SafeArea(
        child: PlannerWidget()
      ),
      routes: {
        //'/': (context) => PlannerWidget(),
        '/newRecipe': (context) => const Text("Form aggiungi nuova ricetta"),
        '/searchRecipe': (context) => const Text("Ricerca ricetta"),
        
      }
    ));
}

