import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/widgets/card/recipe_card.dart';
import 'package:zdor_app/widgets/style/constant.dart';

class SavedRecipesPage extends StatefulWidget {
  @override
  State<SavedRecipesPage> createState() => _SavedRecipesPageState();
}

class _SavedRecipesPageState extends State<SavedRecipesPage> {
  @override
  Widget build(BuildContext context) {
    // Ottieni la lista delle ricette salvate dal servizio
    List<Recipe> savedRecipesList = RecipesService().getFavouriteRecipes();
    RecipesService r = RecipesService();
    

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
                  isSaved: "true", // Imposta isSaved a true perché stiamo visualizzando le ricette già salvate
                  onToggleFavorite: () {
                    setState(() {
                      r.removeSavedRecipe(recipe);
                    });
                  },
                );
              },
            ),
    );
  }
}
