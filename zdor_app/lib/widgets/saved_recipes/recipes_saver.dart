import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/widgets/card/recipe_card.dart';

class RecipeSaveButton extends StatelessWidget {
  final Recipe recipe;
  final List<Recipe> savedRecipesList;
  final Function(List<Recipe>) onSave;

  RecipeSaveButton({
    required this.recipe,
    required this.savedRecipesList,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSaved = savedRecipesList.contains(recipe);

    return IconButton(
      icon: Icon(
        isSaved ? Icons.bookmark : Icons.bookmark_border,
        color: isSaved ? Colors.orange : null,
      ),
      onPressed: () {
        List<Recipe> updatedList = List.from(savedRecipesList);
        if (isSaved) {
          updatedList.remove(recipe);
        } else {
          updatedList.add(recipe);
        }
        onSave(updatedList);
      },
    );
  }
}
