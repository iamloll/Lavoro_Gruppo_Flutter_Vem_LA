import 'package:flutter/material.dart';
import 'package:zdor_app/constant.dart';

class ModifyListScreen extends StatefulWidget {
  final Function(List<String> ingredients) onOk;

  const ModifyListScreen({super.key, required this.onOk});
  @override
  _ModifyListScreenState createState() => _ModifyListScreenState();
}

class _ModifyListScreenState extends State<ModifyListScreen> {
  final _addController = TextEditingController();

  List<String> selectedIngredients = [];

  void addIngredient(String ingredient) {
    setState(() {
      selectedIngredients.add(ingredient);
    });
  }

  void removeIngredient(String ingredient) {
    setState(() {
      selectedIngredients.remove(ingredient);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Modifica lista'),
        centerTitle: true,
        backgroundColor: kBlackColor,
        foregroundColor: kWhiteColor,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _addController,
              cursorColor: kWhiteColor,
              style: TextStyle(color: kWhiteColor),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: kOrangeColor,
                  ),
                ),
                filled: true,
                fillColor: kDarkGreyColor,
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  color: kOrangeColor,
                  onPressed: () {
                    if (_addController.text.trim().isEmpty) {
                      // Il testo contiene solo spazi, quindi non aggiungere l'ingrediente
                    } else {
                      // Il testo non contiene solo spazi, quindi aggiungi l'ingrediente
                      addIngredient(_addController.text);
                      _addController.clear();
                    }
                  },
                ),
                hintText: "Aggiungi un ingrediente...",
                hintStyle: TextStyle(
                  color: kGreyColor,
                  fontSize: 20.0,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 20.0,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Visualizza gli ingredienti trovati nella ricerca escludendo quelli già selezionati
          ...selectedIngredients
              .where((ingredient) => !selectedIngredients.contains(ingredient))
              .map(
                (ingredient) => ListTile(
                  title: Text(
                    ingredient,
                    style: TextStyle(color: kWhiteColor),
                  ),
                  onTap: () {
                    addIngredient(
                        ingredient); // Aggiungi l'ingrediente selezionato
                  },
                ),
              ),
          // Visualizza gli ingredienti selezionati dall'utente, escludendo quelli già presenti nella lista degli ingredienti cercati
          if (selectedIngredients.isNotEmpty) Divider(), // Separatore
          if (selectedIngredients.isNotEmpty)
            Text(
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
                      style: TextStyle(color: kWhiteColor),
                    ),
                  ),
                  if (selectedIngredients.isNotEmpty)
                    IconButton(
                      // Aggiunge la condizione qui
                      icon: Icon(Icons.delete),
                      color: kOrangeColor,
                      onPressed: () {
                        removeIngredient(ingredient);
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: kBlackColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onOk(selectedIngredients);
          //qui va la callback per fissare i nuovi ingredienti alla lista degli ingredienti acquistabili
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
