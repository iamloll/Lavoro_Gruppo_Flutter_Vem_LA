import 'package:zdor_app/models/meal_planner.dart';

//Servizio per il Planner
class PlannerService {

  //creo una lista di MealPlanner base
  List<MealPlanner> createWeeklyPlannerBaseList() {
    List<MealPlanner> data = [];

    //Itero l'enum dei giorni della settimana
    WeekDays.values.forEach((day) {
      //Itero l'enum dei pasti
      Meals.values.forEach((meal) {
        //Creo un MealPlanner con le combinazioni di tutti i giorni, tutti i pasti e assegno ad ognuno una lista vuota nella quale andranno gli id delle ricette
        final mealPlanner = MealPlanner(day: day, meal: meal, recipes: []);
        //Aggiungo il nuovo MealPlanner alla lista 
        data.add(mealPlanner);
      });
    });

    return data;
  }
}