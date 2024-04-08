import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/widgets/recipe_card.dart';
import 'package:zdor_app/widgets/bottom_navigation_bar.dart' as Custom;
import 'package:zdor_app/constant.dart';

class SavedRecipesPage extends StatelessWidget {
  final List<Recipe> savedRecipesList;
  final void Function(int) onPageChanged; // Funzione per cambiare la pagina

  const SavedRecipesPage({
    Key? key,
    required this.savedRecipesList,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        title: Text('Ricette Salvate'),
      ),
      body: savedRecipesList.isEmpty
          ? Center(
              child: Text(
                'Nessuna ricetta salvata',
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: savedRecipesList.length,
              itemBuilder: (context, index) {
                final recipe = savedRecipesList[index];
                return RecipeCard(
                  recipe: recipe,
                  isSaved: true,
                  onSave: () {
                    // Implementa la logica per gestire il salvataggio/rimozione della ricetta
                  },
                );
              },
            ),
      bottomNavigationBar: Custom.CustomNavigationBar(
        currentPageIndex: 2,
        onPageChanged: onPageChanged, // Passa la funzione onPageChanged alla barra di navigazione personalizzata
      ),
    );
  }
}
