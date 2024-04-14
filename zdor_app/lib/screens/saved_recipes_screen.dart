import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/widgets/card/recipe_card.dart';
import 'package:zdor_app/widgets/recipe_detail/modify_recipe.dart';
import 'package:zdor_app/widgets/style/constant.dart';

class SavedRecipesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    
    return Consumer<RecipeState>(builder: (context, state, child) {
      // Ottieni la lista delle ricette salvate dal servizio
      final savedRecipesList = state.recipes.getFavouriteRecipes(); 
      return Scaffold(
        backgroundColor: kBlackColor,
        appBar: AppBar(
          title: Text('Ricette Salvate'),
          actions: [IconButton(
            icon: Icon(Icons.add, color: kOrangeColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ModifyRecipe(onSave: (r) => state.saveRecipe(r) ,)),
              );
            },
          )]
        ),
        body: savedRecipesList.isEmpty
            ? Center(
                child: Text(
                  'Nessuna ricetta salvata',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: savedRecipesList.length,
                itemBuilder: (context, index) {
                  final recipe = savedRecipesList[index];
                  return RecipeCard(
                    recipe: recipe,
                    onToggleFavorite: (value) {
                      final isFavourite = value.isFavourite == "true" ? false : true;                       
                      state.setFavourite(value, isFavourite: isFavourite);                      
                    },
                  );
                },
              ),
      );
    });
  }
}
