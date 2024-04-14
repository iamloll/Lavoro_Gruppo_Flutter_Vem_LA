import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/screens/recipe_detail_screen.dart'; // Importa la schermata dei dettagli della ricetta
import 'package:zdor_app/screens/saved_recipes_screen.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/widgets/style/constant.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;  
  final ValueSetter<Recipe> onToggleFavorite;

  RecipeCard(
      {required this.recipe, required this.onToggleFavorite});

  @override
  Widget build(BuildContext context) {    
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailScreen(
                  recipe:
                      recipe), // Passa la ricetta alla schermata dei dettagli
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: 22, vertical: 10), // Margini orizzontali e verticali
          width: MediaQuery.of(context)
              .size
              .width, // Larghezza del container pari alla larghezza dello schermo
          height: 180, // Altezza fissa del container
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(15), // Bordo arrotondato
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(0.6), // Ombra nera con opacità 0.6
                offset: Offset(
                  0.0,
                  10.0,
                ),
                blurRadius: 10.0,
                spreadRadius: -6.0,
              ),
            ],
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.35),
                BlendMode.multiply,
              ),
              image: AssetImage(recipe.image ?? ''), // Immagine della ricetta
              fit: BoxFit
                  .cover, // Adatta l'immagine per coprire tutto il container
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black
                        .withOpacity(0.4), // Sfondo scuro con opacità 0.4
                    borderRadius:
                        BorderRadius.circular(15), // Bordo arrotondato
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule, // Icona dell'orologio
                        color: kOrangeColor,
                        size: 18, // Dimensione dell'icona
                      ),
                      SizedBox(width: 7),
                      Text(
                        recipe.prep_time ?? '',
                        style: TextStyle(color: kWhiteColor),
                      ), // Tempo di preparazione della ricetta
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    recipe.title ?? '', // Titolo della ricetta
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 19, // Dimensione del testo
                    ),
                    overflow: TextOverflow
                        .ellipsis, // Tronca il testo se troppo lungo
                    maxLines: 2, // Numero massimo di linee per il testo
                    textAlign:
                        TextAlign.center, // Allineamento del testo al centro
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: recipe.isFavourite == "true"
                      ? Icon(Icons.favorite, color: Colors.red)
                      : Icon(Icons.favorite_border, color: kOrangeColor),
                  onPressed: () {
                    onToggleFavorite(recipe);
                  },
                ),
              ),
            ],
          ),
        ),
      );
   }
}
