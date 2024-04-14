import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/screens/home.dart';
import 'package:zdor_app/screens/screen_selector/main_screen.dart';
import 'package:zdor_app/states/recipe_state.dart';
import '../widgets/recipe_detail/recipe_detail.dart';
import 'package:zdor_app/widgets/recipe_detail/share_recipe.dart';
import 'package:zdor_app/widgets/style/constant.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/widgets/recipe_detail/modify_recipe.dart';

//------Callback non ancora funzionante---------

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe; // Parametro per la ricetta

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  static const headerStyle =
      TextStyle(color: kWhiteColor, fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeState>(
      builder: (context, value, child) {
        final r = value.recipes.firstWhere((e) => e.id == recipe.id);
        return Scaffold(
          backgroundColor: kBlackColor,
          appBar: AppBar(
            backgroundColor: kBlackColor,
            shape: Border(bottom: BorderSide(color: kWhiteColor, width: 1)),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: kWhiteColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
            title:
                Text(r.title ?? '', style: TextStyle(color: kWhiteColor)),
            actions: <Widget>[
              PopupMenuButton(
                  icon: Icon(
                    Icons.menu,
                    color: kWhiteColor,
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text("Modifica"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ModifyRecipe(recipe: recipe, onSave: (r) => value.saveRecipe(r) ,)),
                          );
                        },
                      ),
                      PopupMenuItem(
                        child: r.isFavourite == "true" ? Text("Elimina dai preferiti") : Text("Salva"),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(                                
                                title: r.isFavourite == "true" ? Text("Vuoi eliminare la ricetta dalle salvate?") : Text("Vuoi salvare la ricetta?"),
                                actions: [
                                  ElevatedButton(
                                        style: ButtonStyle(                                          
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  kWhiteColor),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.fromLTRB(
                                                  15, 0, 15, 0)),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(0, 30)),
                                        ),
                                        onPressed: () {
                                          final isFavourite = recipe.isFavourite == "true" ? false : true;
                                          value.setFavourite(recipe, isFavourite: isFavourite);
                                          Future.delayed(Duration(seconds: 1), () {
                                            Navigator.of(context).popUntil((route) => route.isFirst);
                                          }); 
                                          showDialog(
                                            context: context,
                                            builder: (context) {                                              
                                              return AlertDialog(
                                                title: isFavourite == false ? Text("Ricetta eliminata!") : Text("Ricetta salvata"),
                                              );
                                            }
                                          ); 
                                                                                                                            
                                        },
                                        child: r.isFavourite == "true" ? Text('Elimina', style: TextStyle(color: kBlackColor)) : Text('Salva', style: TextStyle(color: kBlackColor)),
                                      )
                                ],
                                actionsAlignment: MainAxisAlignment.center,
                              );
                            });}),

                            // context: context,
                            // position: RelativeRect.fromLTRB(100, 150, 0, 0),
                            // items: [
                            //   PopupMenuItem(
                            //     child: Container(
                            //       width: 200, //Width of confirmation item
                            //       child: Column(
                            //         children: [
                            //           r.isFavourite == "true" ? Text("Vuoi eliminare la ricetta dalle salvate?") : Text("Vuoi salvare la ricetta?"),
                            //           ElevatedButton(
                            //             style: ButtonStyle(
                            //               backgroundColor:
                            //                   MaterialStateProperty.all(
                            //                       kWhiteColor),
                            //               padding: MaterialStateProperty.all(
                            //                   EdgeInsets.fromLTRB(
                            //                       15, 0, 15, 0)),
                            //               minimumSize:
                            //                   MaterialStateProperty.all(
                            //                       Size(0, 30)),
                            //             ),
                            //             onPressed: () {
                            //               final isFavourite = recipe.isFavourite == "true" ? false : true;
                            //               value.setFavourite(recipe, isFavourite: isFavourite);
                            //               final snackBar = SnackBar(content: isFavourite == false ? Text("Ricetta eliminata!") : Text("Ricetta salvata"));
                            //               ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            //             },
                            //             child: r.isFavourite == "true" ? Text('Elimina', style: TextStyle(color: kBlackColor)) : Text('Salva', style: TextStyle(color: kBlackColor)),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            
                      
                      PopupMenuItem(
                        child: Text("Condividi"),
                        onTap: () {
                          showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(
                                100, 200, 100, 0), // Adjust position as needed
                            items: [
                              PopupMenuItem(
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
                RecipeDetail(recipe: r), // Mostra i dettagli della ricetta
          ),
        );
      },
    );
  }
}
