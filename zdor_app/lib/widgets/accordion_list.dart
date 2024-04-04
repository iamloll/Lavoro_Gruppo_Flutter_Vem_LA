import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zdor_app/models/models.dart';
import 'package:zdor_app/services/planner_service.dart';
import 'package:zdor_app/widgets/accordion_item.dart';

import 'add_recipe_to_meal_button.dart';

class AccordionList extends StatelessWidget {
  AccordionList({
    super.key,
    this.nestedWidget,
  });

  // final List<String> week_days = ["Lunedì", "Martedì", "Mercoledì", "Giovedì", "Venerdì", "Sabato", "Domenica"];
  // final List<String> meals_list = ["Colazione", "Pranzo", "Cena"];

  final wp = PlannerService().createWeeklyPlannerBaseList();

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
                        isOpen: m == Meals.breakfast,
                        nestedWidget: const Column(
                          children: <Widget>[
                            RowRecipe(),
                            AddRecipeToMealButton(),
                          ],
                        ));
                  }).toList()));
        }).toList());
  }
}

class RowRecipe extends StatelessWidget {
  const RowRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: ListTile(
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
          ),
        ],
      ),
    );
  }
}
