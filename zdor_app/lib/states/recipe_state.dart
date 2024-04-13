import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/services/recipes_service.dart';

class RecipeState extends ChangeNotifier {
  late List<Recipe> _savedRecipes;

  RecipeState() {
    _savedRecipes = RecipesService().getFavouriteRecipes();
  }

  UnmodifiableListView<Recipe> get savedRecipes =>
      UnmodifiableListView(_savedRecipes);

  void saveRecipe(Recipe recipe) {
    recipe.isFavourite = "true";
    _savedRecipes.add(recipe);
    //savedRecipes.add(recipe);

    print(recipe);
    //print(_savedRecipes.toString());
    notifyListeners();
  }

  void removeSavedRecipe(Recipe recipe) {
    _savedRecipes.firstWhere((element) => element.id == recipe.id).isFavourite =
        "false";

    print(recipe);
    //print(_savedRecipes.toString());
    notifyListeners();
  }
}
