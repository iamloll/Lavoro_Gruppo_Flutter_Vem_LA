import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/models/models.dart';
import 'package:zdor_app/states/planner_state.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/widgets/planner/add_menu.dart';
import 'package:zdor_app/widgets/planner/row_recipe.dart';

class AccordionItemRecipes extends StatelessWidget {
  final WeekDays day;
  final Meals meal;

  const AccordionItemRecipes({
    super.key,
    required this.day,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<PlannerState, RecipeState>(
      builder: (context, planState, recipeState, child) {
        return Column(
          children: [
            ...planState.planner
                .firstWhere((el) {
                  return el.day == day && el.meal == meal;
                })
                .recipes
                .map((elem) {
                  final recipe = recipeState.recipes.getRecipeById(elem);
                  return RowRecipe(
                    recipe: recipe,
                    onDelete: () {                      
                      planState.deleteRecipe(day, meal, int.parse(recipe.id!));
                    },
                  );
                }),
            AddMenu(day: day, meal: meal)
          ],
        );
      },
    );
  }
}
