import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/screens/recipe_detail_screen.dart';
import 'package:zdor_app/widgets/style/constant.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;  
  final ValueSetter<Recipe> onToggleFavorite;

  const RecipeCard(
      {super.key, required this.recipe, required this.onToggleFavorite});

  @override
  Widget build(BuildContext context) {    
      //Rendo la card sensibile ad alcune azioni
      return GestureDetector(
        onTap: () {
          //Al click della card navigo verso il dettaglio della ricetta cliccata
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
          margin: const EdgeInsets.symmetric(
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
                offset: const Offset(
                  0.0,
                  10.0,
                ),
                blurRadius: 10.0,
                spreadRadius: -6.0,
              ),
            ],
            //Immagine della ricetta usata come sfondo del container
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
              //TEMPO DI PREPARAZIONE
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black
                        .withOpacity(0.4), // Sfondo scuro con opacità 0.4
                    borderRadius:
                        BorderRadius.circular(15), // Bordo arrotondato
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.schedule, // Icona dell'orologio
                        color: kOrangeColor,
                        size: 18, // Dimensione dell'icona
                      ),
                      const SizedBox(width: 7),
                      Text(
                        recipe.prep_time ?? '',
                        style: const TextStyle(color: kWhiteColor),
                      ), // Tempo di preparazione della ricetta
                    ],
                  ),
                ),
              ),
              //TITOLO DELLA RICETTA
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    recipe.title ?? '', // Titolo della ricetta
                    style: const TextStyle(
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
              //ICONA CUORE
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  //Uso due icone a seconda del flag isFavourite
                  icon: recipe.isFavourite == "true"
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : const Icon(Icons.favorite_border, color: kOrangeColor),
                  onPressed: () {
                    //Callback alla pressione del cuore
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
