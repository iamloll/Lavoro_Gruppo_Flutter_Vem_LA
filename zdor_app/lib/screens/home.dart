import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/widgets/card/recipe_card.dart';
import 'package:zdor_app/widgets/card/horizontal_recipe_card.dart';
import 'package:zdor_app/widgets/searchbar/recipe_search_bar.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<RecipeState>(
          builder: (context, state, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                RecipeSearchBar(
                  searchController: _searchController,
                  onSearch: (query) {
                    final findRecipes =
                        state.recipes.getRecipeByInput(query).toList();
                    showModalBottomSheet(
                        context: context,
                        builder: (bc) {
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 22.0,top: 10.0),
                                  child: Text("Risultati:", style: TextStyle(fontSize: 35), textAlign: TextAlign.left,),
                                ),
                                const SizedBox(height: 5),
                                ...findRecipes
                                    .map((e) => RecipeCard(recipe: e, onToggleFavorite: (value) {                                      
                                    },))
                              ],
                            ),
                          );
                        }, isScrollControlled: true);
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
                      for (final r in state.recipes.getFavouriteRecipes())
                        RecipeCardHorizontal(
                            recipe: r,
                            onToggleFavorite: (recipe) {
                              final isFavourite =
                                  recipe.isFavourite == "true" ? false : true;
                              state.setFavourite(recipe,
                                  isFavourite: isFavourite);
                            }),
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
                    for (final r in state.recipes)
                      RecipeCard(
                        recipe: r,
                        onToggleFavorite: (recipe) {
                          final isFavourite = recipe.isFavourite == "true" ? false : true;
                          state.setFavourite(recipe, isFavourite: isFavourite);
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
