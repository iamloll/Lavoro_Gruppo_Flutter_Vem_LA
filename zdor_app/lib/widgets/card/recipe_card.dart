import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/screens/recipe_detail_screen.dart'; // Importa la schermata dei dettagli della ricetta
import 'package:zdor_app/widgets/style/constant.dart';

class RecipeCard extends StatefulWidget {
  final Recipe recipe;
  final bool isSaved; // Nuovo parametro per indicare se la ricetta è salvata o meno
  final VoidCallback? onSave; // Nuovo parametro per la funzione di salvataggio della ricetta

  RecipeCard({required this.recipe, this.isSaved = false, this.onSave}); // Costruttore con i nuovi parametri opzionali

  @override
  _RecipeCardState createState() => _RecipeCardState(); // Crea lo stato associato al widget
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: widget.recipe), // Passa la ricetta alla schermata dei dettagli
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10), // Margini orizzontali e verticali
        width: MediaQuery.of(context).size.width, // Larghezza del container pari alla larghezza dello schermo
        height: 180, // Altezza fissa del container
        decoration: BoxDecoration(
          color: kWhiteColor, 
          borderRadius: BorderRadius.circular(15), // Bordo arrotondato
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6), // Ombra nera con opacità 0.6
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
            image: AssetImage(widget.recipe.image ?? ''), // Immagine della ricetta
            fit: BoxFit.cover, // Adatta l'immagine per coprire tutto il container
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
                  color: Colors.black.withOpacity(0.4), // Sfondo scuro con opacità 0.4
                  borderRadius: BorderRadius.circular(15), // Bordo arrotondato
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
                      widget.recipe.prep_time ?? '',
                      style: TextStyle(
                        color: kWhiteColor
                      ),
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
                  widget.recipe.title ?? '', // Titolo della ricetta
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 19, // Dimensione del testo
                  ),
                  overflow: TextOverflow.ellipsis, // Tronca il testo se troppo lungo
                  maxLines: 2, // Numero massimo di linee per il testo
                  textAlign: TextAlign.center, // Allineamento del testo al centro
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(
                  widget.isSaved ? Icons.favorite : Icons.favorite_border, // Icona cuore pieno o vuoto
                  color: widget.isSaved ? kRedColor : kOrangeColor, // Colore dell'icona in base al preferito
                  size: 20, // Dimensione dell'icona
                ),
                onPressed: () {
                  if (widget.onSave != null) {
                    widget.onSave!(); // Esegui la funzione di salvataggio, se definita
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
