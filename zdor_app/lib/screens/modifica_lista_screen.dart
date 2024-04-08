import 'package:flutter/material.dart';
import 'package:zdor_app/widgets/style/constant.dart';
import '../widgets/checking_modifica_button.dart';
import 'lista_spesa_screen.dart';

final List<String> newIngredients = [];

class ModifyListScreen extends StatefulWidget {
  @override
  _ModifyListScreenState createState() => _ModifyListScreenState();
}

class _ModifyListScreenState extends State<ModifyListScreen> {
  List<String> searchedIngredients = [];
  List<String> selectedIngredients = [];

  void addIngredient(String ingredient) {
    setState(() {
      selectedIngredients.add(ingredient);
      searchedIngredients.remove(ingredient);
    });
  }

  void removeIngredient(String ingredient) {
    setState(() {
      selectedIngredients.remove(ingredient);
    });
  }

  void _navigateToIngredientList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IngredientListScreen(),
      ),
    );
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
                    if (newIngredients.isNotEmpty) {
                      addIngredient(newIngredients.last);
                      newIngredients.clear();
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
              onChanged: (value) {
                setState(() {
                  newIngredients.add(value);
                });
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Visualizza gli ingredienti trovati nella ricerca escludendo quelli già selezionati
          ...searchedIngredients
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
          Divider(), // Separatore
          Text(
            'Ingredienti selezionati:',
            style: TextStyle(color: kWhiteColor, fontSize: 18.0),
          ),
          ...selectedIngredients
              .where((ingredient) => !searchedIngredients.contains(ingredient))
              .map(
                (ingredient) => ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          ingredient,
                          style: TextStyle(color: kWhiteColor),
                        ),
                      ),
                      IconButton(
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
          _navigateToIngredientList(context);
          //qui va la callback per fissare i nuovi ingredienti alla lista degli ingredienti acquistabili
        },
        child: checking_modifica_button(),
      ),
    );
  }
}
