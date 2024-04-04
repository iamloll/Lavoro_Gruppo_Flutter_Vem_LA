import 'package:flutter/material.dart';
import 'package:zdor_app/models/meal_planner.dart';

// enum WeekDays { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }
// enum MealsList { Breakfast, Lunch, Dinner }

class PlannerService { 
  //PlannerService() {createWeeklyPlannerBaseList();}

  List<MealPlanner> createWeeklyPlannerBaseList() { 
    List<MealPlanner> data = [];

    WeekDays.values.forEach((day) {
      Meals.values.forEach((meal) {
        final mealPlanner = MealPlanner(day: day,meal: meal,recipes: []);
        data.add(mealPlanner);
       });
     });
    
    //data.forEach((data) => print(data));
    return data;
  }

  
  Iterable<MealPlanner> addRecipeToPlanner(WeekDays day, Meals meal, int idRecipe) {
    final List<MealPlanner> mealPlanner = createWeeklyPlannerBaseList();


    for (final m in mealPlanner) {
      // print(m);
      if (m.day == day && m.meal == meal) {
        // print("Trovato");
        m.recipes.add(idRecipe);
        // print(m.recipes);
      }
    }
    mealPlanner
    .firstWhere((e) => e.day == day && e.meal == meal)
    .recipes.add(idRecipe);
    
    mealPlanner.forEach((meal) => print(meal) );
    return mealPlanner;
  }
}


//ESEMPIO
// final recipesInPlanner = [
//   (0, 0, []), 
//   (0, 1, []), 
//   (0, 2, []), 
//   (1, 0, []), 
//   (1, 1, []), 
//   (1, 2, []), 
//   (2, 0, []), 
//   (2, 1, []), 
//   (2, 2, []), 
//   (3, 0, []), 
//   (3, 1, []), 
//   (3, 2, []), 
//   (4, 0, []), 
//   (4, 1, []), 
//   (4, 2, []), 
//   (5, 0, []), 
//   (5, 1, []), 
//   (5, 2, []), 
//   (6, 0, []), 
//   (6, 1, []), 
//   (6, 2, [])
//   ];