//import 'package:accordion/accordion.dart';
//import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
//import 'package:zdor_app/main.dart';
import 'package:zdor_app/services/recipes_service.dart';
//import 'package:zdor_app/widgets/share_buttons.dart';
import 'recipe_detail.dart';
import 'share_recipe.dart';


class RecipeDetailScreen extends StatelessWidget {
  static const headerStyle = TextStyle(
      color: Color.fromARGB(255, 255, 255, 255), fontSize: 18, fontWeight: FontWeight.bold);

  const RecipeDetailScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final recipesList = RecipesService().getRecipes(results: 10).toList();
    return Scaffold(
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

        //Recipe title
        title: Text(recipesList[1].title!, style: TextStyle(color: Colors.white),),

        //Appbar menu
        actions: <Widget>[
          //menuAccordion(headerStyle: headerStyle)
          PopupMenuButton(icon: Icon(Icons.menu, color: Colors.white,),itemBuilder: (context) {
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
                  // Quando l'utente tocca "Condividi", mostra un nuovo menu per le opzioni di condivisione
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(100, 100, 0, 100), // Posizione del menu, da personalizzare
                    items: [
                      PopupMenuItem(child: Container(
                        width: 300, // Larghezza desiderata per il PopupMenuItem con ShareRecipe
                        child: ShareRecipe(),)
                      ),
                    ],
                  );
                },
              ),
              PopupMenuItem(
                child: Text("Salva"),
                onTap: () {
                },
              ),
            ];
          })
        ],
      ),

      //Recipe detail page with vertical scrolling
      body: SingleChildScrollView(
        child: RecipeDetail(),
      ),
    );
  }
}
