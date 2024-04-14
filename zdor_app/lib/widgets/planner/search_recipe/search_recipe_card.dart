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
    return Consumer2<PlannerState, RecipeState>(
        builder: (context, planState, recipeState, child) {
      return GestureDetector(
        onTap: () {
          planState.addRecipe(
              day, meal, int.parse(recipe.id!));
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
                              final isFavourite = recipe.isFavourite == "true" ? false : true;
                              recipeState.setFavourite(recipe, isFavourite: isFavourite);
                            },
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
                        Flexible(
                            child: Text(
                          recipe.title!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        )),
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
