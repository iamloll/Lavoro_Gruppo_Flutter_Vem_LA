import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/models/meal_planner.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/widgets/card/recipe_card.dart';
import 'package:zdor_app/widgets/searchbar/recipe_search_bar.dart';
import 'package:zdor_app/widgets/style/constant.dart';
import '../widgets/planner/search_recipe/cards_grid_view.dart';
import '../widgets/planner/search_recipe/filter_tags.dart';

class SearchRecipeForPlannerScreen extends StatefulWidget {
  const SearchRecipeForPlannerScreen({
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
    //Metto a disposizione lo stato per la modifica delle ricette
    //Il read, a differenza del watch o del consumer, non renderizza di nuovo tutto il widget al cambio dei dati nello stato
    final recipeState = context.read<RecipeState>();
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar( 
        backgroundColor: kBlackColor ,
        toolbarHeight: 80 ,    
        //BARRA DI RICERCA   
        title: RecipeSearchBar(
          onFocusChanged: (isFocused) {
            //Imposto il focus della barra
            setState(() {
              _isSearchFocused = isFocused;
            });
          },
          onSearch: (query) {
            //Ottengo una lista di ricette che contengono nel titolo la string inserita in input
            final findRecipes = recipeState.recipes.getRecipeByInput(query).toList();
            //Visualizzo i risultati in un modale che sale dal basso
            showModalBottomSheet(context: context, builder: (bc) {
              return SingleChildScrollView(
                child: Column(
                children: [
                  const Text("Risultati:"),
                  const SizedBox(height: 20),
                  //Mappo la lista ottenuta in delle card passandogli la singola ricetta ma non il comportamento per l'aggiunta ai preferiti
                  ...findRecipes.map((e) => RecipeCard(recipe: e, onToggleFavorite: (value) {                    
                  },))
                  ],
                ),
              );
            }, isScrollControlled: true);
          },
          searchController: _searchController,
        ),
      ),
      //CORPO DELLA PAGINA
      body: Column(          
          children: [ 
            //Linea di divisione tra la barra di ricerca e il corpo della pagina
            const Divider(              
              color: Colors.white
            ),
            //TAG FILTRI
            const FilterTags(),
            //LISTA DI CARD
            CardsGridView(day: widget.day, meal: widget.meal)
          ],
        ),      
    );    
  }
}