import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/services/recipes_service.dart';

class RecipeState extends ChangeNotifier {
  late List<Recipe> _recipes;

  RecipeState() {
    _recipes = RecipesService().getRecipes(results: 30).toList();
  }

  UnmodifiableListView<Recipe> get recipes => UnmodifiableListView(_recipes);

  void saveRecipe(Recipe recipe) {
    final incrementMaxIndex = (_recipes.length + 1).toString();
    late Recipe newRecipe;
    final oldRecipe = _recipes
          .firstWhere((element) => element.id == recipe.id, orElse: () => Recipe());

    if (oldRecipe.id != null) {
      final index = _recipes.indexOf(oldRecipe);
      newRecipe = oldRecipe.copyWith(
              title: recipe.title,
              category: recipe.category,
              image: recipe.image ?? "assets/image_recipes/no_image.jpg",
              ingredients_list: recipe.ingredients_list,
              procedure: recipe.procedure,
              prep_time: recipe.prep_time,
              isFavourite: recipe.isFavourite ?? "false");

      _recipes.removeWhere((element) => element.id == recipe.id);
      _recipes.insert(index, newRecipe);

      // _recipes.removeWhere((element) => element.id == recipe.id);
    } else {
      newRecipe = Recipe(
          id: incrementMaxIndex,
          title: recipe.title,
          category: recipe.category,
          image: recipe.image ?? "assets/image_recipes/no_image.jpg",
          ingredients_list: recipe.ingredients_list,
          procedure: recipe.procedure,
          prep_time: recipe.prep_time,
          isFavourite: recipe.isFavourite ?? "true");

      _recipes.add(newRecipe);
    }    

    notifyListeners();
  }

  void setFavourite(Recipe recipe, {bool isFavourite = false}) {
    final String boolString = isFavourite.toString();
    final r = _recipes
        .firstWhere((element) => element.id == recipe.id)
        .copyWith(isFavourite: boolString);
    saveRecipe(r);

    //print(recipe);
    // notifyListeners();
  }
}

extension RecipesGetter on List<Recipe> {
  Recipe getRecipeById(int id) {
    final initialList = this;

    final Recipe recipe = initialList.firstWhere((r) => int.parse(r.id!) == id);

    return recipe;
  }

  List<Recipe> getRecipeByInput(String query) {
    final initialList = this;

    final List<Recipe> recipes = initialList.where((r) {
      final String lowerTitle = r.title!.toLowerCase();
      return lowerTitle.contains(query);
    }).toList();

    return recipes;
  }

  List<Recipe> getFavouriteRecipes() {
    final initialList = this;

    final List<Recipe> favourite = initialList.where((e) {
      return e.isFavourite == 'true';
    }).toList();

    return favourite;
  }

  List<String> getCategories() {
    final initialList = this;
    final List<String> catList = [];

    final cat = initialList.map((e) {
      if (!catList.contains(e.category)) {
        catList.add(e.category!);
      }
    }).toList();

    return catList;
  }
}
