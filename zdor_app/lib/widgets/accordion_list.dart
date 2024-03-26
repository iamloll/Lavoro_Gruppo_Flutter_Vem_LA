import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:zdor_app/widgets/accordion_item.dart';

class AccordionList extends StatelessWidget {
  AccordionList({
    super.key,
    this.nestedWidget,     
  });

  final List<String> week_days = ["Lunedì", "Martedì", "Mercoledì", "Giovedì", "Venerdì", "Sabato", "Domenica"];
  final List<String> meals_list = ["Colazione", "Pranzo", "Cena"];

  static const headerStyle = TextStyle(color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);  
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
      headerPadding:
          const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
      sectionClosingHapticFeedback: SectionHapticFeedback.light,
      maxOpenSections: week_days.length,
      children: List.generate(
        week_days.length, 
        (index) => AccordionItem.buildAccordionSection(
          headerText: week_days[index], 
          headerStyle: headerStyle, 
          index: index,
          nestedWidget: Accordion(
            headerBorderColor: const Color.fromARGB(255, 230, 160, 97),
            headerBorderColorOpened: const Color.fromARGB(255, 230, 160, 97),
            headerBorderWidth: 1,
            headerBackgroundColorOpened: const Color.fromARGB(255, 1, 1, 1),
            contentBackgroundColor: const Color.fromARGB(255, 1, 1, 1),
            contentHorizontalPadding: 20,
            scaleWhenAnimating: true,
            openAndCloseAnimation: true,
            headerPadding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
            sectionClosingHapticFeedback: SectionHapticFeedback.light,
            maxOpenSections: week_days.length,
            children: List.generate(
              meals_list.length, 
              (index) => AccordionItem.buildAccordionSection(
                headerText: meals_list[index], 
                headerStyle: headerStyle, 
                index: index,
                //nestedWidget: 
              )
            ),
        )
      ))
    );
  }
}
