import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zdor_app/services/recipes_service.dart';

import '../widgets/planner/search_recipe/cards_grid_view.dart';
import '../widgets/planner/search_recipe/search_recipe_card.dart';

class SearchRecipeForPlannerScreen extends StatelessWidget {
  const SearchRecipeForPlannerScreen
({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 1, 1),
      appBar: AppBar(
        title: const Center(
          child: Column(
            children: [
              Text('Search Bar'),
              SizedBox(),
              Text("Filter tags")
            ],
          )),
      ),
      body: CardsGridView()
    );    
  }
}
