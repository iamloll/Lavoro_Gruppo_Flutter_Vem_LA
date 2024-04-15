import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:zdor_app/models/meal_planner.dart';
import 'package:zdor_app/services/planner_service.dart';

//Imposto uno stato per gestire le modifiche al Planner Pasti
class PlannerState extends ChangeNotifier {
  late List<MealPlanner> _planner;

  PlannerState() {
    //Creo una lista privata di MealPlanner con le combinazioni di possibili giorni, possibili pasti e una lista di ricette vuota
    //ES: [{giorno1,pasto1,[]},{giorno1,pasto2,[]}, ecc]
    _planner = PlannerService().createWeeklyPlannerBaseList();
  }

  //Creo un getter per accedere alla lista privata
  get planner => UnmodifiableListView(_planner);

  //Aggiungere l'id di una ricetta ad un MealPlanner
  void addRecipe(WeekDays day, Meals meal, int idRecipe) {
    //Cerco il MealPlanner che mi interessa modificare controllando il giorno e il pasto specifico
    final MealPlanner recipesIdAdd = _planner.firstWhere((element) => element.day == day && element.meal == meal);
    //Aggiungo l'id della ricetta passata al MealPlanner trovato
    recipesIdAdd.recipes.add(idRecipe);
    //Metto un listener in ascolto per reagire alle modifiche appena apportate
    notifyListeners();
  }

  //Cancellare l'id di una ricetta da un MealPlanner
  void deleteRecipe(WeekDays day, Meals meal, int idRecipe) {
    //Cerco il MealPlanner che mi interessa modificare controllando il giorno e il pasto specifico
    final MealPlanner recipesIdDel = _planner.firstWhere((element) => element.day == day && element.meal == meal);
    //Rimuovo l'id della ricetta passata dal MealPlanner trovato
    recipesIdDel.recipes.remove(idRecipe);
    //Metto un listener in ascolto per reagire alle modifiche appena apportate
    notifyListeners();
  }
}