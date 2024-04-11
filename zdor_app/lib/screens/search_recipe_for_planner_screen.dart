import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/widgets/card/recipe_card.dart';
import 'package:zdor_app/widgets/searchbar/recipe_search_bar.dart';
import 'package:zdor_app/widgets/style/constant.dart';

import '../widgets/planner/search_recipe/cards_grid_view.dart';

class SearchRecipeForPlannerScreen extends StatefulWidget {
  SearchRecipeForPlannerScreen
({super.key});

  @override
  State<SearchRecipeForPlannerScreen> createState() => _SearchRecipeForPlannerScreenState();
}

class _SearchRecipeForPlannerScreenState extends State<SearchRecipeForPlannerScreen> {

final TextEditingController _searchController = TextEditingController();
bool _isSearchFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: kBlackColor,
      appBar: AppBar( 
        backgroundColor: kBlackColor ,
        toolbarHeight: 150 ,       
        title: Column(          
          children: [            
            RecipeSearchBar(
              onFocusChanged: (isFocused) {
                setState(() {
                  _isSearchFocused = isFocused;
                });
              },
              onSearch: (query) {
                print('Ricerca: $query');
                final findRecipes = RecipesService().getRecipeByInput(query).toList();
                print("trovati $findRecipes");              
                showModalBottomSheet(context: context, builder: (bc) {
                  return SingleChildScrollView(
                    child: Column(
                    children: [
                      ...findRecipes.map((e) => RecipeCard(recipe: e)).toList()
                      ],
                    ),
                  );
                });
              },
              searchController: _searchController,
            ),
            Divider(
              color: Colors.white
            ),
            FilterTags(),
          ],
        ),
      ),
      body: CardsGridView()
    );    
  }
}

class FilterTags extends StatefulWidget {
  FilterTags({super.key});

  @override
  State<FilterTags> createState() => _FilterTagsState();
}

class _FilterTagsState extends State<FilterTags> {
  final categories = RecipesService().getCategories();

  String? selectedValue;

  void setSelectedValue(String? value) {
    setState(() {
      selectedValue = value;
      //return; 
      });
  }

  @override
  Widget build(BuildContext context) {
    return Choice<String>.inline(
          clearable: true,
          value: ChoiceSingle.value(selectedValue),
          onChanged: ChoiceSingle.onChanged(setSelectedValue),
          itemCount: categories.length,
          itemBuilder: (state, i) {
            return Row(
              children: [
                ChoiceChip(
                  selected: state.selected(categories[i]),
                  onSelected: state.onSelected(categories[i]),
                  label: Text(categories[i]),
                ),
              ],
            );
          },
          listBuilder: ChoiceList.createScrollable(            
            spacing: 10,
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5,
            ),
          ),
        );   
  }
}
