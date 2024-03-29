import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zdor_app/screens/lista_spesa_screen.dart';
import 'package:zdor_app/services/recipes_service.dart';

void main() {
  //QUI VA IL COMPONENTE BASE DA VISUALIZZARE NELL'APP
  runApp(MaterialApp(
    //elimino il flag debug in alto a destra
    debugShowCheckedModeBanner: false,
    home: SafeArea(child: IngredientListScreen()),
  ));
}

class RecipesListView extends StatelessWidget {
  RecipesListView({super.key});

  //chiamo il mio servizio e ottengo una lista di 10 ricette
  final recipesList = RecipesService().getRecipes(results: 10).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //costruisco una List View con la lista di 10 ricette ottenuto a riga 12
        body: ListView.builder(
            //itemCount = lunghezza della lista da visualizzare
            itemCount: recipesList.length,
            //itemBuilder = come visualizzare la lista
            itemBuilder: (context, index) {
              final r = recipesList[index];
              return Card(
                child: Column(
                  //la colonna sarà allineata al centro
                  mainAxisAlignment: MainAxisAlignment.center,
                  //nella colonna visualizzo titolo, categoria, ingredienti e procedura (esempio base)
                  children: [
                    Text(r.title!),
                    Text(r.category!),
                    Text(r.ingredients_list!.toString()),
                    Text(r.procedure!),
                  ],
                ),
              );
            }));
  }
}
