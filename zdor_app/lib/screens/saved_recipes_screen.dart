import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/widgets/card/recipe_card.dart';
import 'package:zdor_app/widgets/recipe_detail/modify_recipe.dart';
import 'package:zdor_app/widgets/style/constant.dart';

class SavedRecipesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    
    //Metto a disposizione del widget lo stato per la modifica alle ricette
    return Consumer<RecipeState>(builder: (context, state, child) {
      // Ottiengo la lista delle ricette salvate dallo stato
      final savedRecipesList = state.recipes.getFavouriteRecipes(); 
      return Scaffold(
        backgroundColor: kBlackColor,
        //TITOLO
        appBar: AppBar(
          title: const Text('Ricette Salvate'),
          //BOTTONE AGGIUNTA
          actions: [IconButton(
            icon: const Icon(Icons.add, color: kOrangeColor),
            onPressed: () {
              //Alla pressione del pulsante navigo verso la pagina di aggiunta di una nuova ricetta
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        //Non passo una ricetta perchè ne sto creando una nuova da zero, ma specifico il comportamento in fase di salvataggio
                        ModifyRecipe(onSave: (r) => state.saveRecipe(r) ,)),
              );
            },
          )]
        ),
        //CORPO DELLA PAGINA
        body: savedRecipesList.isEmpty
            //Visualizzo un testo di avviso se non sono presenti ricette salvate
            ? const Center(
                child: Text(
                  'Nessuna ricetta salvata',
                  style: TextStyle(color: Colors.white),
                ),
              )
            //Altrimenti visualizzo una lista di card di ricette
            : ListView.builder(
                itemCount: savedRecipesList.length,
                itemBuilder: (context, index) {
                  final recipe = savedRecipesList[index];
                  return RecipeCard(
                    recipe: recipe,
                    onToggleFavorite: (value) {
                      //Gestisco il cambiamento del flag isFavourite al suo opposto, tramite lo stato
                      final isFavourite = value.isFavourite == "true" ? false : true;                       
                      state.setFavourite(value, isFavourite: isFavourite);                      
                    },
                  );
                },
              ),
      );
    });
  }
}
