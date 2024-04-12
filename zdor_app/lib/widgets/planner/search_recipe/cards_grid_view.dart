import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/models/meal_planner.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/states/category_state.dart';
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
    final c = context.watch<CategoryState>();
    final recipes = RecipesService()
        .getRecipes(results: 30)
        .where((e) => e.id != null)
        .toList();

    return Consumer<CategoryState>(
      builder: (context, value, child) {
        return Flexible(
        child: GridView.count(     
          primary: false,
          padding: const EdgeInsets.all(5),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2,
          children: [
            ...(c.selectedCategory != null 
            ?  RecipesService().getRecipes(results: 30).where((e) { 
            print("sel val grid --> ${c.selectedCategory}");
            return e.category == c.selectedCategory;
            }).map((el) =>
              SearchRecipeCard(recipe: el, day: day, meal: meal)
            ).toList() 
            : recipes.map((e) =>
               SearchRecipeCard(recipe: e, day: day, meal: meal)
            ).toList())
          ],
        ),
      );
      },
      // child: Flexible(
      //   child: GridView.count(     
      //     primary: false,
      //     padding: const EdgeInsets.all(5),
      //     crossAxisSpacing: 5,
      //     mainAxisSpacing: 5,
      //     crossAxisCount: 2,
      //     children: [
      //       ...(c.selectedCategory != null 
      //       ?  RecipesService().getRecipes().where((e) { 
      //       print("sel val grid --> ${c.selectedCategory}");
      //       return e.category == c.selectedCategory;
      //       }).map((el) =>
      //          SearchRecipeCard(title: el.title!, category: el.category!, image: el.image!)
      //       ).toList() 
      //       : recipes.map((e) =>
      //          SearchRecipeCard(title: e.title!, category: e.category!, image: e.image!)
      //       ).toList())
      //     ],
      //   ),
      // ),
    );
  }
}
