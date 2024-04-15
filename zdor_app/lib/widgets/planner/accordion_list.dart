import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:zdor_app/models/models.dart';
import 'package:zdor_app/widgets/planner/accordion_item.dart';
import 'package:zdor_app/widgets/style/constant.dart';

import 'accordion_item_recipes.dart';

class AccordionList extends StatelessWidget {
  const AccordionList({
    super.key,
    this.nestedWidget,
  });

  //Stile per i titoli degli accordion
  static const headerStyle = TextStyle(color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  final List<Widget>? nestedWidget;

  @override
  Widget build(BuildContext context) {
    //GIORNI DELLA SETTIMANA
    return Accordion(
        //HEADER STYLE
        headerBorderColor: kOrangeColor,
        headerBorderColorOpened: kOrangeColor,
        headerBorderWidth: 1,
        headerBackgroundColorOpened: kBlackColor,
        headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        //CONTENT STYLE
        contentBackgroundColor: kBlackColor,
        contentHorizontalPadding: 20,
        //ANIMAZIONI
        scaleWhenAnimating: true,
        openAndCloseAnimation: true,        
        sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
        sectionClosingHapticFeedback: SectionHapticFeedback.light,
        maxOpenSections: 1 , //Num massimo di accordion aperti contemporaneamente
        children: WeekDays.values.map((e) {          
          return AccordionItem.buildAccordionSection(
              headerText: e.toString(), //Uso il giorno della settimana come titolo
              headerStyle: headerStyle,
              isOpen: e == WeekDays.monday, //Lunedì è aperto di default
              //PASTI
              nestedWidget: Accordion(
                  //HEADER
                  headerBorderColor: kOrangeColor,
                  headerBorderColorOpened: kOrangeColor,
                  headerBorderWidth: 1,
                  headerBackgroundColorOpened: kBlackColor,
                  headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  //CONTENTE
                  contentBackgroundColor: kBlackColor,
                  contentHorizontalPadding: 20,
                  //ANIMAZIONI
                  scaleWhenAnimating: true,
                  openAndCloseAnimation: true,                  
                  sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                  sectionClosingHapticFeedback: SectionHapticFeedback.light,
                  maxOpenSections: 1, //Numero massimo di accordion aperti contemporaneamente
                  children: Meals.values.map((m) {
                    return AccordionItem.buildAccordionSection(
                        headerText: m.toString(), //Uso il pasto come titolo dell'accordion
                        headerStyle: headerStyle,
                        isOpen: m == Meals.lunch, //Pranzo è aperto di default
                        nestedWidget: AccordionItemRecipes(day: e, meal: m) //Passo il giorno e il pasto in cui sono alla visualizzazione delle eventuali ricette
                    );
                  }).toList()
            ));
        }).toList());
  }
}