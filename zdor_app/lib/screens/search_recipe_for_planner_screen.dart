import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/models/meal_planner.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/states/category_state.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/widgets/card/recipe_card.dart';
import 'package:zdor_app/widgets/searchbar/recipe_search_bar.dart';
import 'package:zdor_app/widgets/style/constant.dart';
import '../widgets/planner/search_recipe/cards_grid_view.dart';
import '../widgets/planner/search_recipe/filter_tags.dart';

class SearchRecipeForPlannerScreen extends StatefulWidget {
  SearchRecipeForPlannerScreen({
    super.key,
    required this.day, 
    required this.meal
  });

  final WeekDays day;
  final Meals meal;

  @override
  State<SearchRecipeForPlannerScreen> createState() => _SearchRecipeForPlannerScreenState();
}

class _SearchRecipeForPlannerScreenState extends State<SearchRecipeForPlannerScreen> {

  final TextEditingController _searchController = TextEditingController();
  bool _isSearchFocused = false;
  
  @override
  Widget build(BuildContext context) {
    final recipeState = context.read<RecipeState>();
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar( 
        backgroundColor: kBlackColor ,
        toolbarHeight: 80 ,       
        title: RecipeSearchBar(
          onFocusChanged: (isFocused) {
            setState(() {
              _isSearchFocused = isFocused;
            });
          },
          onSearch: (query) {
            final findRecipes = recipeState.recipes.getRecipeByInput(query).toList();
            showModalBottomSheet(context: context, builder: (bc) {
              return SingleChildScrollView(
                child: Column(
                children: [
                  Text("Risultati:"),
                  SizedBox(height: 20),
                  ...findRecipes.map((e) => RecipeCard(recipe: e, onToggleFavorite: (value) {                    
                  },)).toList()
                  ],
                ),
              );
            }, isScrollControlled: true);
          },
          searchController: _searchController,
        ),
      ),
      body: Column(          
          children: [ 
            const Divider(              
              color: Colors.white
            ),
            FilterTags(),
            CardsGridView(day: widget.day, meal: widget.meal)
          ],
        ),      
    );    
  }
}