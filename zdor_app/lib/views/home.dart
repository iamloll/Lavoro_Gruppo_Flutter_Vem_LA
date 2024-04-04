import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/widgets/recipe_card.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/constant.dart';
import 'package:zdor_app/widgets/horizontal_recipe_card.dart';
import 'package:zdor_app/widgets/recipe_search_bar.dart';
import 'package:zdor_app/widgets/bottom_navigation_bar.dart' as Custom; 


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {
  // Lista di ricette prese dal servizio di ricette
  final List<Recipe> recipesList = RecipesService().getRecipes(results: 10).toList();
  int currentPageIndex = 0; 
  final TextEditingController _searchController = TextEditingController(); // Controller per la barra di ricerca
  bool _isSearchFocused = false; // Variabile booleana per tenere traccia del focus sulla barra di ricerca

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Il colore di sfondo della schermata varia in base a se la barra di ricerca ha il focus o meno
      backgroundColor: _isSearchFocused ? Colors.black.withOpacity(0.8) : kBlackColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Widget per la barra di ricerca delle ricette
            RecipeSearchBar(
              searchController: _searchController,
              onSearch: (query) {
                // Logica per la ricerca delle ricette
                print('Ricerca: $query');
              },
              onFocusChanged: (isFocused) {
                setState(() {
                  _isSearchFocused = isFocused; // Aggiorna lo stato del focus sulla barra di ricerca
                });
              },
            ),
            SizedBox(height: 20),
           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Le tue Ricette',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10), 
            // Visualizzazione orizzontale delle ricette
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final r in recipesList)
                    RecipeCardHorizontal(recipe: r),// Richiamo la classe RecipeCardHorizontal che mostra orizontalmente le ricette
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                'Ricette Suggerite',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Visualizzazione verticale delle ricette
            Column(
              children: [
                for (final r in recipesList)
                  RecipeCard(recipe: r),// Richiamo la classe RecipeCard che mostra verticalmente le ricette
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      // Widget per la barra di navigazione personalizzata
      bottomNavigationBar: Custom.CustomNavigationBar(
        currentPageIndex: currentPageIndex,
        onPageChanged: (int index) {
          setState(() {
            currentPageIndex = index; // Aggiorna l'indice della pagina corrente
          });
        },
      ),
    );
  }
}
