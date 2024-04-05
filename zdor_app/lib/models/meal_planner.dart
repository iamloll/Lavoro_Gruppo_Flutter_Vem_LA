enum WeekDays { 
  monday, 
  tuesday, 
  wednesday, 
  thursday, 
  friday, 
  saturday, 
  sunday;
  
  @override
  String toString() {
    switch (this) {
      case WeekDays.monday:
        return "Lunedì";
      case WeekDays.tuesday:
        return "Martedì";
      case WeekDays.wednesday:
        return "Mercoledì";
      case WeekDays.thursday:
        return "Giovedì";
      case WeekDays.friday:
        return "Venerdì";
      case WeekDays.saturday:
        return "Sabato";
        case WeekDays.sunday:
        return "Domenica";
      default:
        throw Error();
    }
  }}

enum Meals {
  breakfast,
  lunch,
  dinner;

  @override
  String toString() {
    switch (this) {
      case Meals.breakfast:
        return "Colazione";
      case Meals.lunch:
        return "Pranzo";
      case Meals.dinner:
        return "Cena";
      default:
        throw Error();
    }
  }
}

class MealPlanner {
  WeekDays day;
  Meals meal;
  List<int> recipes;

  MealPlanner({required this.day, required this.meal, required this.recipes});

  @override
  String toString() => '($day, $meal, $recipes)';
}
