import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/states/category_state.dart';
import 'package:zdor_app/states/recipe_state.dart';

class FilterTags extends StatelessWidget {

  const FilterTags({super.key});

  @override
  Widget build(BuildContext context) { 
    final catState = context.read<CategoryState>();  
    final catList = context.read<RecipeState>().recipes.getCategories();
    return Choice<String>.inline(
          clearable: true,
          value: ChoiceSingle.value(catState.selectedCategory),         
          onChanged: ChoiceSingle.onChanged((value) {
            catState.changeCategory(value);
          }),
          itemCount: catList.length,
          itemBuilder: (state, i) {
            return Row(
              children: [
                ChoiceChip(
                  selected: state.selected(catList[i]),
                  onSelected: state.onSelected(catList[i]),
                  label: Text(catList[i]),
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
