//import 'package:accordion/accordion.dart';
//import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
//import 'package:zdor_app/main.dart';
import 'package:zdor_app/services/recipes_service.dart';
//import 'package:zdor_app/widgets/share_buttons.dart';
import 'recipe_detail.dart';
import 'share_recipe.dart';

import 'package:zdor_app/models/recipe.dart'; // Importa la classe Recipe

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
        title: Text(recipesList[4].title!, style: TextStyle(color: Colors.white),),

        //Appbar menu
        actions: <Widget>[
          //menuAccordion(headerStyle: headerStyle)
          PopupMenuButton(icon: Icon(Icons.menu, color: Colors.white,),itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text("Modifica"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ModifyRecipe()),
                  );
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
                  //When pressed shows an options menu
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(100, 100, 0, 100), //menu position
                    items: [
                      PopupMenuItem(child: Container(
                        width: 300, //Width of the item with all the sharing options
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




class ModifyRecipe extends StatefulWidget {
  const ModifyRecipe({Key? key}) : super(key: key);

  @override
  State<ModifyRecipe> createState() => _ModifyRecipeState();
}

class _ModifyRecipeState extends State<ModifyRecipe> {
  String? _title;
  String? _category;
  String? _prepTime;
  String? _ingredients;
  String? _procedure;

  @override
  Widget build(BuildContext context) {
    final Recipe selectedRecipe = RecipesService().getRecipes(results: 10).toList()[4];

    _title = selectedRecipe.title;
    _category = selectedRecipe.category;
    _prepTime = selectedRecipe.prep_time;
    _ingredients = selectedRecipe.ingredients_list != null ? selectedRecipe.ingredients_list!.join('\n') : '';
    _procedure = selectedRecipe.procedure;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Modifica Ricetta'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: _title,
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Titolo'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: _category,
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Categoria'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: _prepTime,
                onChanged: (value) {
                  setState(() {
                    _prepTime = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Tempo'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: _ingredients,
                onChanged: (value) {
                  setState(() {
                    _ingredients = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Ingredienti'),
                maxLines: null,
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: _procedure,
                onChanged: (value) {
                  setState(() {
                    _procedure = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Procedimento'),
                maxLines: null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // final updatedRecipe = selectedRecipe.copyWith(
                  //   title: _title,
                  //   category: _category,
                  //   prep_time: _prepTime,
                  //   ingredients_list: _ingredients != null ? _ingredients!.split('\n') : null,
                  //   procedure: _procedure,
                  // );
                },
                child: Text('Salva'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
