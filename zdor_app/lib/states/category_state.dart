import 'package:flutter/cupertino.dart';

class CategoryState extends ChangeNotifier {
  String? _selectedCategory;

  //CategoryState({this.selectedCategory}); 

  get selectedCategory => _selectedCategory;

  void changeCategory(String newCat) {
    _selectedCategory = newCat;    

    notifyListeners();
  }

}