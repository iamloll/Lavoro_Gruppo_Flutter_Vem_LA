import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zdor_app/constant.dart';

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

class IngredientListScreen extends StatefulWidget {
  @override
  _IngredientListScreenState createState() => _IngredientListScreenState();
}

class _IngredientListScreenState extends State<IngredientListScreen> {
  final List<String> ingredients = List<String>.from(json["acquistabili"]);
  final List<String> bought = List<String>.from(json["acquistati"]);

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          Text(
            'Acquistabili',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: kWhiteColor),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = ingredients[index];
                final isBought = bought.contains(ingredient);
                return Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: kWhiteColor,
                    checkboxTheme: CheckboxThemeData(
                      side: BorderSide(
                        color: kLightOrangeColor,
                      ),
                    ),
                  ),
                  child: CheckboxListTile(
                    title: Text(
                      ingredient,
                      style: TextStyle(color: kWhiteColor),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: isBought,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value != null) {
                          if (value) {
                            bought.add(ingredient);
                            ingredients.remove(ingredient);
                          } else {
                            bought.remove(ingredient);
                            ingredients.add(ingredient);
                          }
                          _updateJson();
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 20.0), // Aggiunge spazio ai lati
            child: Divider(
              // Aggiunta della linea bianca con spazio ai lati
              color: kWhiteColor,
              thickness: 2.0,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Ingredienti Acquistati',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: kWhiteColor),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: bought.length,
              itemBuilder: (context, index) {
                final ingredient = bought[index];
                return ListTile(
                  title: Text(
                    ingredient,
                    style: TextStyle(color: kWhiteColor),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: kLightOrangeColor,
                    onPressed: () {
                      setState(() {
                        bought.remove(ingredient);
                        ingredients.add(ingredient);
                        _updateJson();
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 70.0, // Imposta la larghezza desiderata
        height: 70.0, // Imposta l'altezza desiderata
        padding: EdgeInsets.all(6.0), // Spazio intorno all'icona
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kDarkGreyColor,
          border: Border.all(
            color: kLightOrangeColor,
            width: 2.0,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Aggiungi qui la logica per l'azione del bottone della matita
          },
          backgroundColor: kDarkGreyColor,
          foregroundColor: kLightOrangeColor,
          child:
              Icon(Icons.edit, size: 40.0), // Imposta la grandezza dell'icona
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _updateJson() {
    json['acquistabili'] = List<String>.from(ingredients);
    json['acquistati'] = List<String>.from(bought);
  }
}

void main() {
  runApp(MaterialApp(
    home: IngredientListScreen(),
  ));
}
