import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/widgets/card/recipe_card.dart';
import 'package:zdor_app/widgets/card/horizontal_recipe_card.dart';
import 'package:zdor_app/widgets/style/constant.dart';
import 'package:zdor_app/widgets/searchbar/recipe_search_bar.dart';
import 'package:zdor_app/widgets/saved_recipes/recipes_saver.dart'; 

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Recipe> recipesList = RecipesService().getRecipes(results: 30).toList();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchFocused = false;
  List<Recipe> savedRecipesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isSearchFocused ? Colors.black.withOpacity(0.8) : kBlackColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RecipeSearchBar(
              searchController: _searchController,
              onSearch: (query) {
                print('Ricerca: $query');
                final findRecipes = RecipesService().getRecipeByInput(query).toList();
                print("trovati $findRecipes");
                // return Column(
                //   children: [
                //     ...findRecipes.map((e) => RecipeCard(recipe: e)).toList()
                //   ],
                // );
                showBottomSheet(context: context, builder: (bc) {
                  return Column(
                    
                  children: [
                    ...findRecipes.map((e) => RecipeCard(recipe: e)).toList()
                  ],
                );
                });
              },
              onFocusChanged: (isFocused) {
                setState(() {
                  _isSearchFocused = isFocused;
                });
              },
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Le tue Ricette',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final r in recipesList)
                    RecipeCardHorizontal(recipe: r),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Ricette Suggerite',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                for (final r in recipesList)
                  RecipeCard(
                    recipe: r,
                    isSaved: savedRecipesList.contains(r),
                    onSave: () {
                      setState(() {
                        if (savedRecipesList.contains(r)) {
                          savedRecipesList.remove(r);
                        } else {
                          savedRecipesList.add(r);
                        }
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
