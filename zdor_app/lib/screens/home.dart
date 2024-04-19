import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/widgets/card/recipe_card.dart';
import 'package:zdor_app/widgets/card/horizontal_recipe_card.dart';
import 'package:zdor_app/widgets/searchbar/recipe_search_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

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
        //Metto a disposizione lo stato delle ricette e alla sua modifica il widget verrà renderizzato con i nuovi dati
        child: Consumer<RecipeState>(
          builder: (context, state, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                //BARRA DI RICERCA
                RecipeSearchBar(
                  searchController: _searchController,
                  onSearch: (query) {
                    //Cerco una ricetta che contenga nel titolo la stringa inserita in input
                    final findRecipes =
                        state.recipes.getRecipeByInput(query).toList();
                    //Per visualizzare i risultati uso un modale che sale dal basso
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
                                //Mappo la lista di ricette trovate dalla ricerca in delle RecipeCard senza la possibilità di aggiungere alle salvate
                                ...findRecipes
                                    .map((e) => RecipeCard(recipe: e, onToggleFavorite: (value) {                                      
                                    },))
                              ],
                            ),
                          );
                        }, isScrollControlled: true); //Rendo scrollabile il modale
                  },
                  //Imposto il focus della barra di ricerca
                  onFocusChanged: (isFocused) {
                    setState(() {
                      _isSearchFocused = isFocused;
                    });
                  },
                ),
                const SizedBox(height: 20), //Spazio tra barra di ricerca e corpo della pagina
                //CARD ORIZZONTALI
                //Titolo del primo raggruppamento di card
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
                //Lista di card scrollabili orizzontalmente
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      //Mostro solo le ricette salvate
                      for (final r in state.recipes.getFavouriteRecipes())
                        RecipeCardHorizontal(
                            recipe: r,
                            //Gestisco la modifica del flag isFavourite tramite lo stato
                            onToggleFavorite: (recipe) {
                              final isFavourite =
                                  recipe.isFavourite == "true" ? false : true;
                              state.setFavourite(recipe,
                                  isFavourite: isFavourite);
                            }),
                    ],
                  ),
                ),
                const SizedBox(height: 20), //Spazio tra il primo e il secondo raggruppamento di card
                //CARD VERITCALI
                //Titolo del secondo raggruppamento
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
                //Lista di card scrollabili verticalmente
                Column(
                  children: [
                    //Mostro tutte le ricette per simulare un suggerimento random
                    for (final r in state.recipes)
                      RecipeCard(
                        recipe: r,
                        //Gestisco la modifica del flag isFavourite tramite lo stato
                        onToggleFavorite: (recipe) {
                          final isFavourite = recipe.isFavourite == "true" ? false : true;
                          state.setFavourite(recipe, isFavourite: isFavourite);
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 20), //Spazio tra il corpo della pagina e la navbar
              ],
            );
          },
        ),
      ),
    );
  }
}
