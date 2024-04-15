import 'package:flutter/material.dart';
import 'package:zdor_app/widgets/style/constant.dart';

// Schermo per modificare la lista "Da acquistare che si trova nella lista della spesa"
class ModifyListScreen extends StatefulWidget {
  final Function(List<String> ingredients)
      onOk; // Funzione di callback chiamata quando viene confermata la modifica

  const ModifyListScreen(
      {super.key, required this.onOk}); // Costruttore del widget
  @override
  _ModifyListScreenState createState() =>
      _ModifyListScreenState(); // Metodo per creare lo stato del widget
}

class _ModifyListScreenState extends State<ModifyListScreen> {
  final _addController =
      TextEditingController(); // Controller per il campo di testo per aggiungere nuovi ingredienti

  List<String> selectedIngredients = []; // Elenco degli ingredienti selezionati

  // Metodo per aggiungere un ingrediente alla lista degli ingredienti selezionati
  void addIngredient(String ingredient) {
    setState(() {
      selectedIngredients.add(ingredient);
    });
  }

  // Metodo per rimuovere un ingrediente dalla lista degli ingredienti selezionati
  void removeIngredient(String ingredient) {
    setState(() {
      selectedIngredients.remove(ingredient);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Disabilita il pulsante indietro automatico
        title: const Text('Modifica lista'),
        centerTitle: true,
        // backgroundColor: kBlackColor,
        foregroundColor: kWhiteColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(
              70.0), // Altezza preferita della parte inferiore della barra dell'applicazione
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller:
                  _addController, // Controller controlla cosa viene scritto nel campo di testo
              cursorColor: kWhiteColor,
              style: const TextStyle(color: kWhiteColor),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      30.0), // Bordi arrotondati del campo di testo
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      30.0), // Bordi arrotondati quando premi sulla barra di ricerca e spunta la tastiera
                  borderSide: const BorderSide(
                    color: kOrangeColor,
                  ),
                ),
                filled: true, // Campo di testo riempito
                fillColor: kDarkGreyColor,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  color: kOrangeColor,
                  onPressed: () {
                    if (_addController.text.trim().isEmpty) {
                      // Se il testo è vuoto, non aggiungere l'ingrediente
                    } else {
                      // Se il testo non è vuoto, aggiungi l'ingrediente
                      addIngredient(_addController.text);
                      _addController
                          .clear(); // Pulisci il campo di testo dopo l'aggiunta
                    }
                  },
                ),
                hintText:
                    "Aggiungi un ingrediente...", // Suggerimento per il campo di testo
                hintStyle: const TextStyle(
                  color: kGreyColor,
                  fontSize: 20.0,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15.0, // Riempimento verticale del contenuto
                  horizontal: 20.0, // Riempimento orizzontale del contenuto
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Serve per non far rimanere l'ingrediente sotto la barra di ricerca quando viene eliminato l'ingrediente
            ...selectedIngredients
                .where(
                    (ingredient) => !selectedIngredients.contains(ingredient))
                .map(
                  (ingredient) => ListTile(
                    title: Text(
                      ingredient,
                      style: const TextStyle(color: kWhiteColor),
                    ),
                    onTap: () {
                      addIngredient(
                          ingredient); // Aggiungi l'ingrediente selezionato
                    },
                  ),
                ),
            //visualliza la lista degli ingredienti selezionati solo quando l'utente preme il tasto + per aggiungere
            //un ingrediente alla lista
            if (selectedIngredients.isNotEmpty) const Divider(), // Separatore
            if (selectedIngredients.isNotEmpty)
              const Text(
                'Ingredienti selezionati:',
                style: TextStyle(color: kWhiteColor, fontSize: 18.0),
              ),
            ...selectedIngredients.map(
              (ingredient) => ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        ingredient,
                        style: const TextStyle(color: kWhiteColor),
                      ),
                    ),
                    if (selectedIngredients.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: kOrangeColor,
                        onPressed: () {
                          removeIngredient(
                              ingredient); // Rimuovi l'ingrediente aggiunto alla lista
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // backgroundColor: kBlackColor,
      floatingActionButton: SizedBox(
        width: 70, // Larghezza del pulsante
        height: 70, // Altezza del pulsante
        child: FloatingActionButton(
          onPressed: () {
            widget.onOk(
                selectedIngredients); // Chiamata alla funzione di callback onOK, che aiuta ad aggiungere gli ingredienti selezionati
            //alla lista degli ingredienti "Da acquistare" premendo il bottone check
          },
          backgroundColor: kDarkGreyColor,
          foregroundColor: kOrangeColor,
          shape: const CircleBorder(
            side: BorderSide(
                color: kOrangeColor, width: 2.0), // Bordo del pulsante
          ),
          child: Transform.scale(
            scale: 1.5, // Dimensione del bottone check
            child: const Icon(Icons.check),
          ),
        ),
      ),
    );
  }
}
