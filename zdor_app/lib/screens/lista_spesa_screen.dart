import 'package:flutter/material.dart';
import 'package:zdor_app/widgets/style/constant.dart';
import 'package:zdor_app/screens/modifica_lista_screen.dart'; // Importa la pagina di modifica

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

// ignore: must_be_immutable
class IngredientListScreen extends StatefulWidget {
  List<String> selectedIngredients;

  IngredientListScreen({Key? key, List<String>? selectedIngredients})
      : selectedIngredients = selectedIngredients ?? [],
        super(key: key);

  @override
  _IngredientListScreenState createState() => _IngredientListScreenState();
}

class _IngredientListScreenState extends State<IngredientListScreen> {
  List<String> ingredients = List<String>.from(json["acquistabili"]);
  final List<String> bought = List<String>.from(json["acquistati"]);

  @override
  void initState() {
    super.initState();
    ingredients.addAll(widget.selectedIngredients);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista della spesa'),
        centerTitle: true,
        backgroundColor: kBlackColor,
        foregroundColor: kWhiteColor,
      ),
      backgroundColor: kBlackColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const Text(
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
                    checkboxTheme: const CheckboxThemeData(
                      side: BorderSide(
                        color: kOrangeColor,
                      ),
                    ),
                  ),
                  child: CheckboxListTile(
                    title: Text(
                      ingredient,
                      style: const TextStyle(color: kWhiteColor),
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
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: kWhiteColor,
              thickness: 2.0,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Acquistati',
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
                    style: const TextStyle(color: kWhiteColor),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.check_box),
                    color: kOrangeColor,
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Naviga alla pagina di modifica quando il pulsante della matita viene premuto
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ModifyListScreen(
                        onOk: (ing) {
                          setState(() {
                            ingredients.addAll(ing);
                          });
                          Navigator.pop(context);
                        },
                      )),
            );
          },
          child: const Icon(Icons.edit)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _updateJson() {
    json['acquistabili'] = List<String>.from(ingredients);
    json['acquistati'] = List<String>.from(bought);
  }
}
