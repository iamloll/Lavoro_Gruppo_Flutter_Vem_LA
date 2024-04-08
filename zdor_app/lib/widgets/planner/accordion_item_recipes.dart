import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/models/models.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/widgets/planner/add_menu.dart';
import 'package:zdor_app/widgets/planner/row_recipe.dart';

class AccordionItemRecipes extends StatelessWidget {
  final WeekDays day;
  final Meals meal;
  final _recipeService = RecipesService();

  AccordionItemRecipes({
    super.key,
    required this.day,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.watch<RecipeState>();
    return Column(
      children: [
        ...p.planner
            .firstWhere((el) {
              //print(el);
              return el.day == day && el.meal == meal;
            })
            .recipes
            .map((elem) {
              // print(elem);
              final recipe = _recipeService.getRecipeById(elem);
              return RowRecipe(
                recipe: recipe,
                onDelete: () {
                  p.deleteRecipe(day, meal, int.parse(recipe.id!));
                },
              );
            }),
        // ElevatedButton(
        //   onPressed: () {
        //   p.addRecipe(day, meal, 8);
        // }, child: const Text("Bottone aggiungi"))
        const AddMenu()
      ],
    );
  }
}
