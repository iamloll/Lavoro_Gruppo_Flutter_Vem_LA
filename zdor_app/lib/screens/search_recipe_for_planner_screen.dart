import 'package:choice/choice.dart';
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

class SearchRecipeForPlannerScreen extends StatefulWidget {
  SearchRecipeForPlannerScreen({
    super.key,
    required this.day, 
    required this.meal
  });

  final WeekDays day;
  final Meals meal;

  @override
  State<SearchRecipeForPlannerScreen> createState() => _SearchRecipeForPlannerScreenState(day: day, meal: meal);
}

class _SearchRecipeForPlannerScreenState extends State<SearchRecipeForPlannerScreen> {

  _SearchRecipeForPlannerScreenState({
    required this.day, 
    required this.meal
  });

  final TextEditingController _searchController = TextEditingController();
  final WeekDays day;
  final Meals meal;
  bool _isSearchFocused = false;
  final CategoryState c = CategoryState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipeState(),
      child: Scaffold(
        backgroundColor: kBlackColor,
        appBar: AppBar( 
          //automaticallyImplyLeading: false,
          backgroundColor: kBlackColor ,
          toolbarHeight: 80 ,       
          title: RecipeSearchBar(
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
        ),
        body: ChangeNotifierProvider(
          create: (context) => CategoryState(),
          child: Column(          
              children: [ 
                const Divider(              
                  color: Colors.white
                ),
                FilterTags(),
                CardsGridView(day: day, meal: meal)
              ],
            ),
        ),
        
      ),
    );    
  }
}


class FilterTags extends StatelessWidget {
  final categories = RecipesService().getCategories();
  final CategoryState c = CategoryState();

  String? selectedValue;

  void setSelectedValue(String? value) {
    print("val --> ${c.selectedCategory}");
    c.changeCategory(value!);
    print("sel val --> ${c.selectedCategory}");
  }

  @override
  Widget build(BuildContext context) { 
    final reader = context.read<CategoryState>();   
    return Choice<String>.inline(
          clearable: true,
          value: ChoiceSingle.value(selectedValue), 
          // onChanged: ChoiceSingle.onChanged(setSelectedValue),         
          onChanged: ChoiceSingle.onChanged((value) => reader.changeCategory(value!)),
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

// class FilterTags extends StatefulWidget {
//   FilterTags({super.key});

//   @override
//   State<FilterTags> createState() => _FilterTagsState();
// }

// class _FilterTagsState extends State<FilterTags> {
//   final categories = RecipesService().getCategories();

//   String? selectedValue;

//   void setSelectedValue(String? value) {
//     setState(() {
//       selectedValue = value;
//       //return; 
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Choice<String>.inline(
//           clearable: true,
//           value: ChoiceSingle.value(selectedValue),
//           onChanged: ChoiceSingle.onChanged(setSelectedValue),
//           itemCount: categories.length,
//           itemBuilder: (state, i) {
//             return Row(
//               children: [
//                 ChoiceChip(
//                   selected: state.selected(categories[i]),
//                   onSelected: state.onSelected(categories[i]),
//                   label: Text(categories[i]),
//                 ),
//               ],
//             );
//           },
//           listBuilder: ChoiceList.createScrollable(            
//             spacing: 10,
//             padding: const EdgeInsets.symmetric(
//               horizontal: 5,
//               vertical: 5,
//             ),
//           ),
//         );   
//   }
// }
