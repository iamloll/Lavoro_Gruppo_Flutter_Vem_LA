
import 'package:flutter/material.dart';
import 'package:zdor_app/services/recipes_service.dart';
import '../widgets/recipe_detail/recipe_detail.dart';
import 'package:zdor_app/widgets/recipe_detail/share_recipe.dart';
import 'package:zdor_app/widgets/style/constant.dart';
import 'package:zdor_app/models/recipe.dart'; 
import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/widgets/style/constant.dart';
import 'package:zdor_app/widgets/recipe_detail/modify_recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe; // Parametro per la ricetta

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  static const headerStyle = TextStyle(
      color: kWhiteColor, fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        backgroundColor: kBlackColor,
        shape: Border(
            bottom: BorderSide(
                color: kWhiteColor,
                width: 1
            )
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kWhiteColor,),
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
        title: Text(recipe.title ?? '', style: TextStyle(color: kWhiteColor)),
        actions: <Widget>[
          PopupMenuButton(icon: Icon(Icons.menu, color: kWhiteColor,), itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text("Modifica"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ModifyRecipe(recipe: recipe)),
                  );
                },
              ),
              PopupMenuItem(
                child: Text("Cancella"),
                onTap: () {
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(100, 100, 0, 0),
                    items: [
                      PopupMenuItem(
                        child: Container(
                          width: 200, //Width of confirmation item
                          child: Column(
                            children: [
                              Text("Vuoi cancellare la ricetta?"),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(kWhiteColor),
                                  padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(15, 0, 15, 0)),
                                  minimumSize: MaterialStateProperty.all(Size(0, 30)),
                                ),
                                onPressed: () {
                                  
                                },
                                child: Text('Cancella', style: TextStyle(color: kBlackColor)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              PopupMenuItem(
                child: Text("Salva"),
                onTap: () {
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(100, 150, 0, 0),
                    items: [
                      PopupMenuItem(
                        child: Container(
                          width: 200, //Width of confirmation item
                          child: Column(
                            children: [
                              Text("Vuoi salvare la ricetta?"),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(kWhiteColor),
                                  padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(15, 0, 15, 0)),
                                  minimumSize: MaterialStateProperty.all(Size(0, 30)),
                                ),
                                onPressed: () {
                                  
                                },
                                child: Text('Salva', style: TextStyle(color: kBlackColor)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              PopupMenuItem(
                child: Text("Condividi"),
                onTap: () {
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(100, 200, 100, 0), // Adjust position as needed
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
        child: RecipeDetail(), // Mostra i dettagli della ricetta
      ),
    );
  }
}



