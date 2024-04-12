import 'package:flutter/material.dart';
import 'package:zdor_app/screens/modifica_lista_screen.dart'; // Importa lo schermo per la modifica della lista
import 'package:zdor_app/widgets/style/constant.dart'; // Importa le costanti di stile

// Dati JSON iniziali per la Lista della spesa
final Map<String, dynamic> json = {
  'acquistabili': [
    'Farina',
    'Zucchero',
    'Uova',
    'Latte',
    'Burro',
    'Sale',
    'Pepe',
    'Pomodori',
    'Cipolle',
    'Aglio',
    'Basilico',
    'Olio d\'oliva',
    'Prosciutto',
    'Formaggio',
  ],
  "acquistati": []
};

// Schermo per la visualizzazione e la gestione della lista degli ingredienti
class IngredientListScreen extends StatefulWidget {
  final List<String>
      selectedIngredients; // Elenco degli ingredienti selezionati

  IngredientListScreen({Key? key, List<String>? selectedIngredients})
      : selectedIngredients = selectedIngredients ??
            [], // Inizializza gli ingredienti selezionati con una lista vuota se non specificato
        super(key: key);

  @override
  _IngredientListScreenState createState() =>
      _IngredientListScreenState(); // Crea lo stato associato al widget
}

class _IngredientListScreenState extends State<IngredientListScreen> {
  List<String> ingredients = List<String>.from(json["acquistabili"]);
  final List<String> bought = List<String>.from(json["acquistati"]);

  // Questo permette di visualizzare gli ingredienti già selezionati quando il widget viene costruito per la prima volta
  @override
  void initState() {
    super.initState();
    ingredients.addAll(widget.selectedIngredients);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista della spesa'),
        centerTitle: true,
        backgroundColor: kBlackColor,
        foregroundColor: kWhiteColor,
      ),
      backgroundColor: kBlackColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment
            .stretch, // Allinea gli elementi lungo l'asse trasversale (orizzontale)
        children: [
          Divider(
            color: kWhiteColor, // Colore del separatore
            thickness: 2.0, // Spessore del separatore
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Da acquistare',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: kWhiteColor),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ingredients
                  .length, // Numero totale di ingredienti nella lista
              itemBuilder: (context, index) {
                final ingredient = ingredients[
                    index]; // Ottiene l'ingrediente corrente dall'elenco
                final isBought = bought.contains(
                    ingredient); // Verifica se l'ingrediente è già stato acquistato

                return Theme(
                  // Applica un tema personalizzato per il widget
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: kWhiteColor,
                    checkboxTheme: CheckboxThemeData(
                      side: BorderSide(
                        color: kOrangeColor, // Colore del bordo del checkbox
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: Text(
                            ingredient,
                            style: TextStyle(color: kWhiteColor),
                          ),
                          controlAffinity: ListTileControlAffinity
                              .leading, // Posizione del checkbox rispetto al testo
                          value:
                              isBought, // Valore del checkbox (se selezionato o meno)
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  bought.add(
                                      ingredient); // Aggiunge l'ingrediente agli acquistati
                                  ingredients.remove(
                                      ingredient); // Rimuove l'ingrediente dagli acquistabili
                                } else {
                                  bought.remove(
                                      ingredient); // Rimuove l'ingrediente dagli acquistati
                                  ingredients.add(
                                      ingredient); // Aggiunge l'ingrediente agli acquistabili
                                }
                                _updateJson(); // Aggiorna i dati JSON dopo ogni modifica
                              }
                            });
                          },
                        ),
                      ),
                      // Se l'ingrediente non è stato acquistato, mostra l'icona per eliminare l'ingrediente
                      if (!isBought)
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: kOrangeColor,
                          onPressed: () {
                            setState(() {
                              ingredients.remove(
                                  ingredient); // Rimuove l'ingrediente dagli acquistabili
                              _updateJson(); // Aggiorna i dati JSON dopo la rimozione
                            });
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: kWhiteColor, // Colore del separatore
              thickness: 2.0, // Spessore del separatore
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Acquistati', // Testo per la sezione degli ingredienti acquistati
            textAlign: TextAlign.center, // Allinea il testo al centro
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kWhiteColor), // Stile del testo
          ),
          Expanded(
            child: ListView.builder(
              itemCount: bought
                  .length, // Numero di elementi nella lista degli ingredienti acquistati
              itemBuilder: (context, index) {
                final ingredient = bought[index]; // Ingrediente corrente
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          ingredient,
                          style:
                              TextStyle(color: kWhiteColor), // Stile del testo
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                            Icons.delete), // Icona per eliminare l'ingrediente
                        color: kOrangeColor, // Colore dell'icona
                        onPressed: () {
                          setState(() {
                            bought.remove(
                                ingredient); // Rimuove l'ingrediente dalla lista degli acquistati
                            _updateJson(); // Aggiorna i dati JSON
                          });
                        },
                      ),
                    ],
                  ),
                  leading: IconButton(
                    icon: Icon(Icons
                        .check_box), // Icona per spostare l'ingrediente negli acquistabili
                    color: kOrangeColor, // Colore dell'icona
                    onPressed: () {
                      setState(() {
                        bought.remove(
                            ingredient); // Rimuove l'ingrediente dalla lista degli acquistati
                        ingredients.add(
                            ingredient); // Aggiunge l'ingrediente agli acquistabili
                        _updateJson(); // Aggiorna i dati JSON
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 70, // Larghezza del pulsante
        height: 70, // Altezza del pulsante
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ModifyListScreen(
                  // Naviga alla schermata di modifica della lista
                  onOk: (ing) {
                    setState(() {
                      ingredients.addAll(
                          ing); // Aggiunge gli ingredienti dalla modifica alla lista
                    });
                    Navigator.pop(context); // Chiude la schermata di modifica
                  },
                ),
              ),
            );
          },
          child: Transform.scale(
            scale: 1.5, // Scala dell'icona del pulsante
            child: Icon(Icons.edit), // Icona del pulsante
          ),
          shape: CircleBorder(
            side: BorderSide(
                color: kOrangeColor, width: 2.0), // Bordo del pulsante
          ),
          backgroundColor: kDarkGreyColor, // Colore di sfondo del pulsante
          foregroundColor: kOrangeColor, // Colore dell'icona del pulsante
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // Posizione del pulsante
    );
  }

  void _updateJson() {
    json['acquistabili'] = List<String>.from(
        ingredients); // Aggiorna gli ingredienti acquistabili nei dati JSON
    json['acquistati'] = List<String>.from(
        bought); // Aggiorna gli ingredienti acquistati nei dati JSON
  }
}
