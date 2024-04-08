  import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:zdor_app/models/models.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/widgets/planner/accordion_item.dart';

import 'accordion_item_recipes.dart';

class AccordionList extends StatelessWidget {
  AccordionList({
    super.key,
    this.nestedWidget,
  });

  // final wp = PlannerService().createWeeklyPlannerBaseList();
  // late List<MealPlanner> newWP = PlannerService().addRecipeToPlanner(wp, WeekDays.monday, Meals.lunch, 12);

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
                        nestedWidget: AccordionItemRecipes(day: e, meal: m)
                    );
                  }).toList()
            ));
        }).toList());
  }
}