import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/widgets/style/constant.dart';

class ModifyRecipe extends StatefulWidget {
  final Recipe recipe; // Aggiungi questo parametro al costruttore

  const ModifyRecipe({Key? key, required this.recipe}) : super(key: key);

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
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kWhiteColor),
                ),
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
