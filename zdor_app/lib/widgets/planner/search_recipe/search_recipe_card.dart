import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/models/meal_planner.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/states/planner_state.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/widgets/style/constant.dart';

class SearchRecipeCard extends StatelessWidget {
  final Recipe recipe;
  final WeekDays day;
  final Meals meal;

  const SearchRecipeCard(
      {super.key, required this.recipe, required this.day, required this.meal});

  @override
  Widget build(BuildContext context) {
    //Metto a disposizione gli stati per la modifica del planner e delle ricette
    return Consumer2<PlannerState, RecipeState>(
        builder: (context, planState, recipeState, child) {
      //Rendo le card sensibili ad alcune azioni 
      return GestureDetector(
        onTap: () {
          //Alla pressione della card, aggiungo quella ricetta al giorno e al pasto selezionato del planner
          planState.addRecipe(
              day, meal, int.parse(recipe.id!));
          //Navigo indietro al planner
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                offset: const Offset(0.0, 10.0),
                blurRadius: 10.0,
                spreadRadius: -6.0,
              )
            ],
            //IMMAGINE SFONDO
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.35),
                BlendMode.multiply,
              ),
              image: AssetImage(recipe.image!),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              //ICONA CUORE
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 2.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: IconButton(
                            onPressed: () {
                              //Modifico il flag isFavourite al suo opposto tramite lo stato
                              final isFavourite = recipe.isFavourite == "true" ? false : true;
                              recipeState.setFavourite(recipe, isFavourite: isFavourite);
                            },
                            //Uso due icone a seconda del flag isFavourite
                            icon: recipe.isFavourite == "true"
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    color: kOrangeColor,
                                  )))),
              ),
              //DESCRIZIONE DELLA RICETTA
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(10),
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //TITOLO
                        Flexible(
                            child: Text(
                          recipe.title!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        )),
                        //CATEGORIA
                        Flexible(
                            child: Text(recipe.category!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14)))
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
    });
  }
}
