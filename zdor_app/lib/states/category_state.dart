import 'package:flutter/cupertino.dart';

//Imposto uno stato per gestire la modifica di una categoria
class CategoryState extends ChangeNotifier {
  //Stringa privata
  String? _selectedCategory; 
  //Imposto un getter per accedere alla stringa provata
  get selectedCategory => _selectedCategory;

  //Modifica la stringa privata con la nuova categoria
  void changeCategory(String? newCat) {
    _selectedCategory = newCat;    
    //Metto un listener in ascolto per reagire alle modifiche appena apportate
    notifyListeners();
  }

}