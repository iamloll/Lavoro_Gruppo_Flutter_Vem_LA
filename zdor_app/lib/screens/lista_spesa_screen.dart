import 'package:flutter/material.dart';
import 'package:zdor_app/screens/modifica_lista_screen.dart';
import 'package:zdor_app/widgets/style/constant.dart';

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
                        color: kOrangeColor,
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
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: kWhiteColor,
              thickness: 2.0,
            ),
          ),
          SizedBox(height: 20),
          Text(
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
                    style: TextStyle(color: kWhiteColor),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.check_box),
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
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
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
                ),
              ),
            );
          },
          child: Transform.scale(
            scale: 1.5,
            child: Icon(Icons.edit),
          ),
          shape: CircleBorder(
            side: BorderSide(color: kOrangeColor, width: 2.0),
          ),
          backgroundColor: kDarkGreyColor,
          foregroundColor: kOrangeColor,
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
