import 'package:flutter/material.dart';

class AddRecipeToMealButton extends StatefulWidget {
  const AddRecipeToMealButton({super.key});

  @override
  State<AddRecipeToMealButton> createState() => _AddRecipeToMealButtonState();
}

class _AddRecipeToMealButtonState extends State<AddRecipeToMealButton> {

  var selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,        
        children: [
          Text("Aggiungi una ricetta"),
          PopupMenuButton(
            icon: Icon(Icons.add),
            onSelected: (value) {
            // your logic
              setState(() {
                selectedItem = value.toString();
              });
              print(value);
              Navigator.pushNamed(context, value.toString());
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  child: Text("Aggiungi nuova ricetta"),
                  value: '/newRecipe',
                ),
                PopupMenuItem(
                  child: Text("Cerca ricetta"),
                  value: '/searchRecipe',
                )
              ];
            },
            
          )
        ],
    );
  }
}
