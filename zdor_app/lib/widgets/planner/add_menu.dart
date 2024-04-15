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
    //Metto a disposizione gli stati per la modifica del planner e delle ricette
    final planState = context.read<PlannerState>();
    final recipeState = context.read<RecipeState>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //TITOLO DEL MENU
        const Text("Aggiungi una ricetta"),
        PopupMenuButton(
          //ICONA ADD
          icon: const Icon(Icons.add),
          onSelected: (value) {
            //Se premo aggiungi navigo verso la schermata di creazione di una nuova ricetta
            if (value == 0) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                //Non gli passo una ricetta ma solo il comportamento da eseguire alla richiesta del salvataggio tramite lo stato
                return ModifyRecipe(onSave: (recipe) {
                    Recipe newRecipe = recipeState.saveRecipe(recipe);
                    planState.addRecipe(day, meal, int.parse(newRecipe.id!));
                },);
              }));
              return;
            }
            //Altrimenti navigo verso la schermata di ricerca passandogli giorno e pasto
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return SearchRecipeForPlannerScreen(day: day, meal: meal);
            }));
          },
          itemBuilder: (context) {
            return const [
              //PRIMA RIGA
              PopupMenuItem(
                value: 0,
                child: Text("Aggiungi nuova ricetta"),
              ),
              //SECONDA RIGA
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
