// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:zdor_app/models/meal_planner.dart';
import 'package:zdor_app/services/planner_service.dart';

class RecipeState extends ChangeNotifier {
  late List<MealPlanner> _planner;

  RecipeState() {
    _planner = PlannerService().createWeeklyPlannerBaseList();
  }

  get planner => UnmodifiableListView(_planner);

  void addRecipe(WeekDays day, Meals meal, int idRecipe) {
    final MealPlanner recipesIdAdd = _planner.firstWhere((element) => element.day == day && element.meal == meal);
    recipesIdAdd.recipes.add(idRecipe);

    notifyListeners();
  }

  void deleteRecipe(WeekDays day, Meals meal, int idRecipe) {
    final MealPlanner recipesIdDel = _planner.firstWhere((element) => element.day == day && element.meal == meal);
    recipesIdDel.recipes.remove(idRecipe);

    notifyListeners();
  }
}
