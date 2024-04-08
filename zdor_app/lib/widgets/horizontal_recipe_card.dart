import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/constant.dart';

class RecipeCardHorizontal extends StatefulWidget {
  final Recipe recipe;

  RecipeCardHorizontal({required this.recipe}); // Costruttore che richiede una ricetta come argomento

  @override
  _RecipeCardHorizontalState createState() => _RecipeCardHorizontalState(); // Crea lo stato associato al widget
}

class _RecipeCardHorizontalState extends State<RecipeCardHorizontal> {
  bool _isFavorite = false; // Variabile booleana per tenere traccia dello stato del preferito

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10), // Margini orizzontali e verticali
      width: MediaQuery.of(context).size.width * 0.5, // Larghezza del container pari alla metà della larghezza dello schermo
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
          image: NetworkImage(widget.recipe.image ?? ''), // Immagine della ricetta
          fit: BoxFit.cover, // Adatta l'immagine per coprire tutto il container
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.all(10),
              child: IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border, // Icona cuore pieno o vuoto
                  color: _isFavorite ? kRedColor : kOrangeColor, // Colore dell'icona in base al preferito
                  size: 20, // Dimensione dell'icona
                ),
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite; // Cambia lo stato del preferito quando viene premuto l'icona
                  });
                },
              ),
            ),
          ),
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
                    size: 18, 
                  ),
                  SizedBox(width: 7),
                  Text(widget.recipe.prep_time ?? ''), // Tempo di preparazione della ricetta
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
                  fontSize: 19, 
                ),
                overflow: TextOverflow.ellipsis, // Tronca il testo se troppo lungo
                maxLines: 2, // Numero massimo di linee per il testo
                textAlign: TextAlign.center, // Allineamento del testo al centro
              ),
            ),
          ),
        ],
      ),
    );
  }
}
