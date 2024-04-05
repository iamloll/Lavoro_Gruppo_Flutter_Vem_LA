import 'package:zdor_app/models/meal_planner.dart';

// enum WeekDays { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }
// enum MealsList { Breakfast, Lunch, Dinner }

class PlannerService {
  //PlannerService() {createWeeklyPlannerBaseList();}

  List<MealPlanner> createWeeklyPlannerBaseList() {
    List<MealPlanner> data = [];

    WeekDays.values.forEach((day) {
      Meals.values.forEach((meal) {
        final mealPlanner = MealPlanner(day: day, meal: meal, recipes: []);
        data.add(mealPlanner);
      });
    });

    //data.forEach((data) => print(data));
    return data;
  }

  List<MealPlanner> addRecipeToPlanner(List<MealPlanner> plannerForAdd, WeekDays day, Meals meal, int idRecipe) {

    plannerForAdd
        .firstWhere((e) => e.day == day && e.meal == meal)
        .recipes
        .add(idRecipe);

    //planner.forEach((meal) => print(meal));
    return plannerForAdd;
  }

  List<MealPlanner> deleteRecipeToPlanner(List<MealPlanner> plannerForDelete, WeekDays day, Meals meal, int idRecipe) {

    plannerForDelete
        .firstWhere((e) => e.day == day && e.meal == meal)
        .recipes
        .remove(idRecipe);

    //planner.forEach((meal) => print(meal));
    return plannerForDelete;
  }
}