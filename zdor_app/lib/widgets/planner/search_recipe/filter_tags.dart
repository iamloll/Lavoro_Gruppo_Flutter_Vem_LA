import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/states/category_state.dart';
import 'package:zdor_app/states/recipe_state.dart';

class FilterTags extends StatelessWidget {
  final categories = RecipeState().recipes.getCategories();
  final CategoryState c = CategoryState();

  String? selectedValue;

  FilterTags({super.key});

  void setSelectedValue(String? value) {
    print("val --> ${c.selectedCategory}");
    c.changeCategory(value!);
    print("sel val --> ${c.selectedCategory}");
  }

  @override
  Widget build(BuildContext context) { 
    final reader = context.read<CategoryState>();   
    return Choice<String>.inline(
          clearable: true,
          value: ChoiceSingle.value(selectedValue),         
          onChanged: ChoiceSingle.onChanged((value) => reader.changeCategory(value!)),
          itemCount: categories.length,
          itemBuilder: (state, i) {
            return Row(
              children: [
                ChoiceChip(
                  selected: state.selected(categories[i]),
                  onSelected: state.onSelected(categories[i]),
                  label: Text(categories[i]),
                ),
              ],
            );
          },
          listBuilder: ChoiceList.createScrollable(            
            spacing: 10,
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5,
            ),
          ),
        );   
  }
}
