import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zdor_app/services/recipes_service.dart';

void main() {
  //QUI VA IL COMPONENTE BASE DA VISUALIZZARE NELL'APP
  runApp(
     MaterialApp(
      //elimino il flag debug in alto a destra
      debugShowCheckedModeBanner: false,
      /* dark theme settings */
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const SafeArea(
        child: PlannerWidget()
      ),
    ));
}

class RecipesListView extends StatelessWidget {
  RecipesListView({super.key});

  //chiamo il mio servizio e ottengo una lista di 10 ricette
  final recipesList = RecipesService().getRecipes(results: 10).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //costruisco una List View con la lista di 10 ricette ottenuto a riga 12
      body: ListView.builder(
        //itemCount = lunghezza della lista da visualizzare
        itemCount: recipesList.length,
        //itemBuilder = come visualizzare la lista
        itemBuilder: (context, index) {
          final r = recipesList[index];
          return Card(
            child: Column(
              //la colonna sarà allineata al centro
              mainAxisAlignment: MainAxisAlignment.center,
              //nella colonna visualizzo titolo, categoria, ingredienti e procedura (esempio base)
              children: [
                Text(r.title!),
                Text(r.category!),
                Text(r.ingredients_list!.toString()),                    
                Text(r.procedure!),
              ],
            ),
          );
      })
    );
  }
}

class PlannerWidget extends StatelessWidget {
  

  static const headerStyle = TextStyle(color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  static const contentStyleHeader = TextStyle(color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  static const contentStyle = TextStyle(color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

  const PlannerWidget({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 1, 1),
        appBar: AppBar(
          title: const Text('Planner Pasti'),
          actions: [
            IconButton(
              onPressed: () => {print("Menu button pressed")}, 
              icon: const Icon(Icons.more_vert_rounded))            
          ],
        ),
        body : 
        
        //Accordion(children: List.generate(50, (index) => AccordionSection(header: Text(index.toString()), content: Text(index.toString()))),)
        // body : ListView.builder(
        //   itemCount: 1000,
        //   itemBuilder: (contex,index) {
        //   return Text(index.toString());
        // } )
        DayListAccordion(
          headerStyle: headerStyle, 
          mealListAccordion: Text("ciao"),
          //mealListAccordion: MealListAccordion(
          //  headerStyle: headerStyle
          //)
        )
    );
  }
}

class DayListAccordion extends StatelessWidget {
  DayListAccordion({
    super.key,
    required this.headerStyle, 
    required this.mealListAccordion,
  });

  final List<String> week_days = ["Lunedì", "Martedì", "Mercoledì", "Giovedì", "Venerdì", "Sabato", "Domenica"];
  final Widget mealListAccordion; 
  final TextStyle headerStyle;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //shrinkWrap: true,
      //physics: const ClampingScrollPhysics(),
      itemCount: week_days.length,
      itemBuilder: (context, index) {
        final day = week_days[index];
        return AccordionList(
          headerText: day, 
          headerStyle: headerStyle, 
          index: index, 
          //nestedWidget: mealListAccordion
        );
      }
    );      
  }
}

class MealListAccordion extends StatelessWidget {
  MealListAccordion({
    super.key,
    required this.headerStyle,
  });
 
  final List<String> meals_list = ["Colazione", "Pranzo", "Cena"];
  final TextStyle headerStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        //shrinkWrap: true,
        //physics: const ClampingScrollPhysics(),
        itemCount: meals_list.length,
        itemBuilder: (context, index) {
          final meal = meals_list[index];
          return AccordionList(
            headerText: meal, 
            headerStyle: headerStyle, 
            index: index
          );
        }
      ),
    );      
  }
}

class AccordionList extends StatelessWidget {
  const AccordionList({
    super.key,
    required this.headerText,
    required this.headerStyle,
    required this. index,
    this.nestedWidget, 
    
  });

  final int index; 
  final String headerText;
  final TextStyle headerStyle;
  final Widget? nestedWidget;

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
      children: [
        AccordionItem(headerText: headerText, headerStyle: headerStyle, index: index, nestedWidget: nestedWidget) as AccordionSection,
      ] 
    );
  }
}

class AccordionItem extends StatelessWidget {
  const AccordionItem({
    super.key,
    required this.headerText,
    required this.headerStyle,
    required this.index,
    required this.nestedWidget, 
  });

  final int index;
  final String headerText;
  final TextStyle headerStyle;
  final Widget? nestedWidget;

  @override
  AccordionSection build(BuildContext context) {
    return AccordionSection(
      //isOpen: true,
      isOpen: index == 0 ? true : false,
      header: Text(headerText, style: headerStyle),
      contentHorizontalPadding: 40,
      contentVerticalPadding: 20,
      content: nestedWidget != null ? nestedWidget! : Text("Widget non trovato")
    );
  }
}

