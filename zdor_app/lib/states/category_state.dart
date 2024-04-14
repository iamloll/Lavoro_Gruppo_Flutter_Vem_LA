import 'package:flutter/cupertino.dart';

class CategoryState extends ChangeNotifier {
  String? _selectedCategory; 

  get selectedCategory => _selectedCategory;

  void changeCategory(String? newCat) {
    _selectedCategory = newCat;    

    notifyListeners();
  }

}