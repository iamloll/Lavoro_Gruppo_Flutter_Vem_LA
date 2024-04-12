import 'package:zdor_app/models/meal_planner.dart';

class PlannerService {

  List<MealPlanner> createWeeklyPlannerBaseList() {
    List<MealPlanner> data = [];

    WeekDays.values.forEach((day) {
      Meals.values.forEach((meal) {
        final mealPlanner = MealPlanner(day: day, meal: meal, recipes: []);
        data.add(mealPlanner);
      });
    });

    return data;
  }
}