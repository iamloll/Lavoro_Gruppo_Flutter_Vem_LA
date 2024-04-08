import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/widgets/card/recipe_card.dart';
import 'package:zdor_app/widgets/style/constant.dart';
import 'package:zdor_app/widgets/navbar/bottom_navigation_bar.dart' as Custom;
import 'package:zdor_app/widgets/saved_recipes/recipes_saver.dart'; // Import del widget RecipeSaveButton

class SavedRecipesPage extends StatelessWidget {
  final List<Recipe> savedRecipesList;
  final void Function(int) onPageChanged;

  const SavedRecipesPage({
    Key? key,
    required this.savedRecipesList,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  isSaved: true,
                  onSave: () {
                    if (savedRecipesList.contains(recipe)) {
                      savedRecipesList.remove(recipe);
                    } else {
                      savedRecipesList.add(recipe);
                    }
                  },
                );
              },
            ),
    );
  }
}