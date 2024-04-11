import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/widgets/planner/search_recipe/search_recipe_card.dart';

class CardsGridView extends StatelessWidget { 

  CardsGridView({
    super.key,
    this.cat,
  });

  final String? cat;  
  //final recipes = RecipesService().getRecipes(results: 30).where((e) => e.id != null).toList();
  //final recipesByCat = RecipesService().getRecipes().where((e) => e.category == cat).toList();

  @override
  Widget build(BuildContext context) {

    final recipes = RecipesService().getRecipes(results: 30).where((e) => e.id != null).toList();
    final recipesByCat = RecipesService().getRecipes(results: 30).where((e) => e.category == cat).toList();

    return GridView.count(            
            primary: false,
            padding: const EdgeInsets.all(5),
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: 2,
            children: [
              ...recipes.map((e) {
                return SearchRecipeCard(title: e.title!, category: e.category!, image: e.image!);
              })
              // cat != null ?  recipesByCat.map((el) {
              //   return SearchRecipeCard(title: el.title!, category: el.category!, image: el.image!);
              // }) : recipes.map((e) {
              //   return SearchRecipeCard(title: e.title!, category: e.category!, image: e.image!);
              // })               
              
            ],
          );
  }
}
