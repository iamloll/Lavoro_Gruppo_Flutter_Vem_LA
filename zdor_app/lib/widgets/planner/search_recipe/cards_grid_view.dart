import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/models/meal_planner.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/states/category_state.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/widgets/planner/search_recipe/search_recipe_card.dart';

class CardsGridView extends StatelessWidget {

  CardsGridView({
    super.key,
    required this.day, 
    required this.meal
  });

  final WeekDays day;
  final Meals meal;

    @override
  Widget build(BuildContext context) {  

    return Consumer2<CategoryState, RecipeState>(
      builder: (context, catState, recipeState, child) {
        return Flexible(
        child: GridView.count(     
          primary: false,
          padding: const EdgeInsets.all(5),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
          children: [
            ...recipeState.recipes.getByCategory(catState.selectedCategory)
            .map((el) =>
              SearchRecipeCard(recipe: el, day: day, meal: meal)
            )
          ],
        ),
      );
      },
    );
  }
}
