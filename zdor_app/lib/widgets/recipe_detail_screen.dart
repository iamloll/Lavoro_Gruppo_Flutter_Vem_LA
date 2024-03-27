import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
//import 'package:zdor_app/main.dart';

import 'menu_accordion_options.dart';

class RecipeDetailScreen extends StatelessWidget
{
  static const headerStyle = TextStyle(
      color: Color.fromARGB(255, 255, 255, 255), fontSize: 18, fontWeight: FontWeight.bold);
  const RecipeDetailScreen({super.key});

  @override
  build(context) => Scaffold(
        backgroundColor: Color.fromARGB(255, 1, 1, 1),

        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 1, 1, 1),
          shape: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1
            )
          ),

          //Go back button
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white,),
                onPressed: () {

                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: const Text('Nome Ricetta', style: TextStyle(color: Colors.white),),

          //App bar menu
          actions: <Widget>[
            //menuAccordion(headerStyle: headerStyle)
            PopupMenuButton(icon: Icon(Icons.menu, color: Colors.orange,),itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text("Modifica"),
                  onTap: () {
                  },
                ),
                PopupMenuItem(
                  child: Text("Cancella"),
                  onTap: () {
                  },
                ),
                PopupMenuItem(
                  child: Text("Condividi"),
                  onTap: () {
                  },
                ),
                PopupMenuItem(
                  child: Text("Salva"),
                  onTap: () {
                  },
                ),
              ];
            })
          ]
        ),

        //Accordion menu
        body: recipeDetail(),
  );
}


class recipeDetail extends StatefulWidget {
  const recipeDetail({
    super.key,
    //required this.r,
  });

  @override
  State<recipeDetail> createState() => _recipeDetailState();
}

class _recipeDetailState extends State<recipeDetail> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [Text("Titolo")],
            ),
            SizedBox(
              width: 100,
              height: 100,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("tsts"), Text("tgtgtgt")],
            ),
          ],
        ),
      ),
    );
  }
}

// class menuAccordion extends StatelessWidget {
//   const menuAccordion({
//     super.key,
//     required this.headerStyle,
//   });

//   final TextStyle headerStyle;

//   @override
//   Widget build(BuildContext context) {
//     return Accordion(
//       paddingListHorizontal: 130,
//       headerBackgroundColor: Colors.transparent,
//       //headerBorderColorOpened: Colors.orange,
//       headerBorderWidth: 1,
//       headerBackgroundColorOpened: Colors.transparent,
//       contentBackgroundColor: Color.fromARGB(255, 1, 1, 1),
//       contentBorderColor: Colors.orange,
//       scaleWhenAnimating: true,
//       openAndCloseAnimation: true,
//       headerPadding:
//           const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//       sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
//       sectionClosingHapticFeedback: SectionHapticFeedback.light,
//       children: [
//         AccordionSection(
//           isOpen: false,
//           rightIcon: const Icon(Icons.menu, color: Colors.orange),
//           header: Text('', style: headerStyle),
//           content: const menuAccordionOptions(),
//         ),
//       ],
//     );
//   }
// }
