import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/widgets/card/recipe_card.dart';
import 'package:zdor_app/widgets/style/constant.dart';

class SavedRecipesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ottieni la lista delle ricette salvate dal servizio
    final savedRecipesList = context
        .read<RecipeState>()
        .recipes
        .where((e) => e.isFavourite == "true")
        .toList();
    return Consumer<RecipeState>(builder: (context, state, child) {
      return Scaffold(
        backgroundColor: kBlackColor,
        appBar: AppBar(
          title: Text('Ricette Salvate'),
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
                    //isSaved: "true", // Imposta isSaved a true perché stiamo visualizzando le ricette già salvate
                    onToggleFavorite: () {
                      if (recipe.isFavourite == "true") {
                        state.setFavourite(recipe, isFavourite: false);
                      } else {
                        state.setFavourite(recipe, isFavourite: true);
                      }
                    },
                  );
                },
              ),
      );
    });
  }
}
