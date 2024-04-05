import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:zdor_app/models/models.dart';
import 'package:zdor_app/services/planner_service.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/widgets/accordion_item.dart';

import 'add_recipe_to_meal_button.dart';

class AccordionList extends StatelessWidget {
  AccordionList({
    super.key,
    this.nestedWidget,
  });

  final wp = PlannerService().createWeeklyPlannerBaseList();
  late List<MealPlanner> newWP = PlannerService().addRecipeToPlanner(wp, WeekDays.monday, Meals.lunch, 22);
  final recipes = RecipesService().getRecipes(results: 30).toList();
  

  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  final List<Widget>? nestedWidget;

  @override
  Widget build(BuildContext context) {
    return Accordion(
        headerBorderColor: const Color.fromARGB(255, 230, 160, 97),
        headerBorderColorOpened: const Color.fromARGB(255, 230, 160, 97),
        headerBorderWidth: 1,
        headerBackgroundColorOpened: const Color.fromARGB(255, 1, 1, 1),
        contentBackgroundColor: const Color.fromARGB(255, 1, 1, 1),
        contentHorizontalPadding: 20,
        scaleWhenAnimating: true,
        openAndCloseAnimation: true,
        headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
        sectionClosingHapticFeedback: SectionHapticFeedback.light,
        maxOpenSections: WeekDays.values.length,
        children: WeekDays.values.map((e) {
          return AccordionItem.buildAccordionSection(
              headerText: e.toString(),
              headerStyle: headerStyle,
              isOpen: e == WeekDays.monday,
              nestedWidget: Accordion(
                  headerBorderColor: const Color.fromARGB(255, 230, 160, 97),
                  headerBorderColorOpened:
                      const Color.fromARGB(255, 230, 160, 97),
                  headerBorderWidth: 1,
                  headerBackgroundColorOpened:
                      const Color.fromARGB(255, 1, 1, 1),
                  contentBackgroundColor: const Color.fromARGB(255, 1, 1, 1),
                  contentHorizontalPadding: 20,
                  scaleWhenAnimating: true,
                  openAndCloseAnimation: true,
                  headerPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                  sectionClosingHapticFeedback: SectionHapticFeedback.light,
                  maxOpenSections: WeekDays.values.length,
                  children: Meals.values.map((m) {
                    return AccordionItem.buildAccordionSection(
                        headerText: m.toString(),
                        headerStyle: headerStyle,
                        isOpen: m == Meals.lunch,
                        nestedWidget: Column(
                          children: [
                            ...newWP.firstWhere((el) {
                              //print(el);
                                return el.day == e && el.meal == m;                              
                              }).recipes.map((elem) {
                                // print(elem);
                                final recipe = RecipesService().getRecipeById(elem);
                                return RowRecipe(recipe: recipe);
                              }),
                            const AddRecipeToMealButton()
                          ],
                        )
                    );
                  }).toList()
            ));
        }).toList());
  }
}

class RowRecipe extends StatelessWidget {
  const RowRecipe({
    super.key, 
    required this.recipe
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Card( 
      clipBehavior: Clip.hardEdge,     
      child: Stack( 
        children : [
          AspectRatio(
            aspectRatio: 31/9,
            child: Image.asset(recipe.image!, fit: BoxFit.fitWidth,)),
          Container(
            height: 90,
            decoration: BoxDecoration(color: Colors.grey[700]?.withOpacity(0.6)),
          ),
          Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: ListTile(                
                title: Text(style: TextStyle(color: Colors.white, fontSize: 18), recipe.title!),
                subtitle: Text(style: TextStyle(color: Colors.white, fontSize: 14),recipe.category!),
                trailing: IconButton(onPressed: () => {
                  print("Cancellato"),
                  
                }, icon: Icon(Icons.delete, color: Colors.white,)),
              ),
            ),
          ],
        )],
      ),
    );
  }
}
