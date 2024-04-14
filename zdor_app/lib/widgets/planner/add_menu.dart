import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/models/meal_planner.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/screens/search_recipe_for_planner_screen.dart';
import 'package:zdor_app/states/planner_state.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/widgets/recipe_detail/modify_recipe.dart';

class AddMenu extends StatelessWidget {  
  const AddMenu({
    super.key, 
    required this.day, 
    required this.meal
  });

  final WeekDays day;
  final Meals meal;

  @override
  Widget build(BuildContext context) {
    final planState = context.read<PlannerState>();
    final recipeState = context.read<RecipeState>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Aggiungi una ricetta"),
        PopupMenuButton(
          icon: const Icon(Icons.add),
          onSelected: (value) {
            if (value == 0) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ModifyRecipe(
                  onSave: (recipe) {
                    Recipe newRecipe = recipeState.saveRecipe(recipe);
                    planState.addRecipe(day, meal, int.parse(newRecipe.id!));
                },);
              }));
              return;
            }
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return SearchRecipeForPlannerScreen(day: day, meal: meal);
            }));
          },
          itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: 0,
                child: Text("Aggiungi nuova ricetta"),
              ),
              PopupMenuItem(
                value: 1,
                child: Text("Cerca ricetta"),
              )
            ];
          },
        )
      ],
    );
  }
}
