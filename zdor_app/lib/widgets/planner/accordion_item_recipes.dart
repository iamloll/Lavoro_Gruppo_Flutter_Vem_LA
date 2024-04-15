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
    //Metto a disposizione lo stato per la modifica del planner e delle ricette
    return Consumer2<PlannerState, RecipeState>(
      builder: (context, planState, recipeState, child) {
        return Column(
          children: [
            //CARD RICETTE
            //Cerco il MealPlanner del giorno e del pasto che mi interessa
            ...planState.planner
                .firstWhere((el) {
                  return el.day == day && el.meal == meal;
                })
                //Visualizzo le ricette del MealPlanner trovato
                .recipes
                .map((elem) {
                  final recipe = recipeState.recipes.getRecipeById(elem);
                  //Passo la ricetta da visualizzare e il comportamento, tramite lo stato, da usare alla richesta di cancellazione dal planner
                  return RowRecipe(
                    recipe: recipe,
                    onDelete: () {                      
                      planState.deleteRecipe(day, meal, int.parse(recipe.id!));
                    },
                  );
                }),
            //MENU DI AGGIUNTA RICETTA
            AddMenu(day: day, meal: meal)
          ],
        );
      },
    );
  }
}
