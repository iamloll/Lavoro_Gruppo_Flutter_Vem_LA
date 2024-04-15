import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/screens/recipe_detail_screen.dart';
import 'package:zdor_app/widgets/style/constant.dart';



class RecipeCardHorizontal extends StatelessWidget {
  final Recipe recipe;
  final ValueSetter<Recipe> onToggleFavorite;

  const RecipeCardHorizontal({super.key, required this.recipe, required this.onToggleFavorite});

  @override
  Widget build(BuildContext context) {
      //Rendo la card sensibile ad alcune azioni
      return GestureDetector(
        onTap: () {
          //Al click della card apro il dettaglio della ricetta cliccata
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailScreen(recipe: recipe),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          width: MediaQuery.of(context).size.width * 0.5,
          height: 180,
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                offset: const Offset(
                  0.0,
                  10.0,
                ),
                blurRadius: 10.0,
                spreadRadius: -6.0,
              ),
            ],
            //Immagine della ricetta usata come sfondo del contenitore
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.35),
                BlendMode.multiply,
              ),
              image: AssetImage(recipe.image ?? ''),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              //ICONA CUORE
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: IconButton(
                    //Uso due icone a seconda dello stato di isFavourite
                    icon: recipe.isFavourite == "true"
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(Icons.favorite_border, color: kOrangeColor),
                    onPressed: () {  
                      //Callback alla pressione del cuore
                      onToggleFavorite(recipe);
                    },
                  ),
                ),
              ),
              //TEMPO DI PREPARAZIONE
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.schedule,
                        color: kOrangeColor,
                        size: 18,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        recipe.prep_time ?? '',
                        style: const TextStyle(color: kWhiteColor),
                      ),
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
                    recipe.title ?? '',
                    style: const TextStyle(
                      color: kWhiteColor,
                      fontSize: 19,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    
  }
}
