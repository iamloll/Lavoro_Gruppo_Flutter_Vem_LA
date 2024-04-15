import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/states/recipe_state.dart';
import '../widgets/recipe_detail/recipe_detail.dart';
import 'package:zdor_app/widgets/recipe_detail/share_recipe.dart';
import 'package:zdor_app/widgets/style/constant.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/widgets/recipe_detail/modify_recipe.dart';


class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  static const headerStyle = TextStyle(color: kWhiteColor, fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    //Metto a disposizione lo stato per la manipolazione delle ricette
    return Consumer<RecipeState>(
      builder: (context, value, child) {
        //Ottengo la singola ricetta che devo visualizzare
        final r = value.recipes.firstWhere((e) => e.id == recipe.id);
        return Scaffold(
          backgroundColor: kBlackColor,
          //TITOLO
          appBar: AppBar(
            backgroundColor: kBlackColor,
            shape: const Border(bottom: BorderSide(color: kWhiteColor, width: 1)),
            //Icona di ritorno
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: kWhiteColor,
              ),
              onPressed: () {
                //Alla pressione dell'icona navigo nella schermata principale
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
            //TITOLO RICETTA
            title:
                Text(r.title ?? '', style: const TextStyle(color: kWhiteColor)),
            //MENU LATERALE
            actions: <Widget>[
              PopupMenuButton(
                  //MODIFICA
                  icon: const Icon(
                    Icons.menu,
                    color: kWhiteColor,
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: const Text("Modifica"),
                        onTap: () {
                          //Alla pressione navigo verso la pagina di modifica della ricetta
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                //Passo al widget la ricetta da visualizzare e come comportarsi alla richiesta di salvataggio
                                ModifyRecipe(recipe: recipe, onSave: (r) => value.saveRecipe(r) 
                            ) ),
                          );
                        },
                      ),
                      //SALVA -- ELIMINA
                      PopupMenuItem(
                        //Visualizzazione dei testi condizionale in base al flag isFavourite
                        child: r.isFavourite == "true" ? const Text("Elimina dai preferiti") : const Text("Salva"),
                        onTap: () {
                          //Alla pressione del pulsante apro un dialog centrale alla pagina
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(                                
                                title: r.isFavourite == "true" ? const Text("Vuoi eliminare la ricetta dalle salvate?") : const Text("Vuoi salvare la ricetta?"),
                                actions: [
                                  //BOTTONE SALVA -- ELIMINA
                                  ElevatedButton(
                                        style: ButtonStyle(                                          
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  kWhiteColor),
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.fromLTRB(
                                                  15, 0, 15, 0)),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  const Size(0, 30)),
                                        ),
                                        onPressed: () {
                                          //Alla pressione del pulsante modifico il flag isFavourite all'opposto del suo valore attuale tramite lo stato
                                          final isFavourite = recipe.isFavourite == "true" ? false : true;
                                          value.setFavourite(recipe, isFavourite: isFavourite);
                                          //Dopo un intervallo navigo indietro fino alla pagina iniziale
                                          Future.delayed(const Duration(seconds: 1), () {
                                            Navigator.of(context).popUntil((route) => route.isFirst);
                                          });
                                          //Mostro un messaggio di avvenuta modifica 
                                          showDialog(
                                            context: context,
                                            builder: (context) {                                              
                                              return AlertDialog(
                                                title: isFavourite == false ? const Text("Ricetta eliminata!") : const Text("Ricetta salvata"),
                                              );
                                            }
                                          );                                                                                                                             
                                        },
                                        child: r.isFavourite == "true" ? const Text('Elimina', style: TextStyle(color: kBlackColor)) : const Text('Salva', style: TextStyle(color: kBlackColor)),
                                      )
                                ],
                                //Allineo il bottone al centro
                                actionsAlignment: MainAxisAlignment.center,
                              );
                            });
                          }),
                      //CONDIVIDI
                      PopupMenuItem(
                        child: const Text("Condividi"),
                        onTap: () {
                          showMenu(
                            context: context,
                            position: const RelativeRect.fromLTRB(
                                100, 200, 100, 0), // Adjust position as needed
                            items: [
                              const PopupMenuItem(
                                child: ShareRecipe(),
                              ),
                            ],
                          );
                        },
                      ),
                    ];
                  })
            ],
          ),
          body: SingleChildScrollView(
            child:
                RecipeDetail(recipe: r), // Mostro i dettagli della ricetta
          ),
        );
      },
    );
  }
}
