//import 'package:accordion/accordion.dart';
//import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
//import 'package:zdor_app/main.dart';
import 'package:zdor_app/services/recipes_service.dart';
//import 'package:zdor_app/widgets/share_buttons.dart';
import '../widgets/recipe_detail/recipe_detail.dart';
import '../widgets/recipe_detail/share_recipe.dart';
import 'package:zdor_app/widgets/style/constant.dart';
import 'package:zdor_app/models/recipe.dart'; // Importa la classe Recipe

class RecipeDetailScreen extends StatelessWidget {
  static const headerStyle = TextStyle(
      color: kWhiteColor, fontSize: 18, fontWeight: FontWeight.bold);

  const RecipeDetailScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final recipesList = RecipesService().getRecipes(results: 30).toList();

    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        backgroundColor: kBlackColor,
        shape: Border(
            bottom: BorderSide(
                color: kWhiteColor,
                width: 1
            )
        ),

        //Go back button
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: kWhiteColor,),
              onPressed: () {
                //Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),

        //Recipe title
        title: Text(recipesList[4].title!, style: TextStyle(color: kWhiteColor)),

        //Appbar menu
        actions: <Widget>[
          //menuAccordion(headerStyle: headerStyle)
          PopupMenuButton(icon: Icon(Icons.menu, color: kWhiteColor,),itemBuilder: (context) {
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
    final Recipe selectedRecipe = RecipesService().getRecipes().toList()[4];

    _title = selectedRecipe.title;
    _category = selectedRecipe.category;
    _prepTime = selectedRecipe.prep_time;
    _ingredients = selectedRecipe.ingredients_list != null ? selectedRecipe.ingredients_list!.join('\n') : '';
    _procedure = selectedRecipe.procedure;

    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        backgroundColor: kBlackColor,
        title: Text('Modifica Ricetta', style: TextStyle(color: kWhiteColor)),
        shape: Border(
            bottom: BorderSide(
                color: kWhiteColor,
                width: 1
            )
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: kWhiteColor,),
              onPressed: () {
                Navigator.pop(context);  //Return to previous screen
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                style: TextStyle(color: kWhiteColor),
                initialValue: _title,
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Titolo', labelStyle: TextStyle(color: kWhiteColor)),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: kWhiteColor),
                initialValue: _category,
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Categoria', labelStyle: TextStyle(color: kWhiteColor)),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: kWhiteColor),
                initialValue: _prepTime,
                onChanged: (value) {
                  setState(() {
                    _prepTime = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Tempo', labelStyle: TextStyle(color: kWhiteColor)),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: kWhiteColor),
                initialValue: _ingredients,
                onChanged: (value) {
                  setState(() {
                    _ingredients = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Ingredienti', labelStyle: TextStyle(color: kWhiteColor)),
                maxLines: null,
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: kWhiteColor),
                initialValue: _procedure,
                onChanged: (value) {
                  setState(() {
                    _procedure = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Procedimento', labelStyle: TextStyle(color: kWhiteColor)),
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
                child: Text('Salva', style: TextStyle(color: kBlackColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
