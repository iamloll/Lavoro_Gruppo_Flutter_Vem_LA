import 'package:flutter/material.dart';
import 'package:zdor_app/models/models.dart';

class RowRecipe extends StatelessWidget {
  const RowRecipe({
    super.key, 
    required this.recipe,
    required this.onDelete,
  });

  final Recipe recipe;

  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Card( 
      clipBehavior: Clip.hardEdge,     
      child: Stack( 
        children : [
          AspectRatio(
            aspectRatio: 31/9,
            child: Image.asset(recipe.image!, fit: BoxFit.fitWidth,)),
          Container(
            height: 95,
            decoration: BoxDecoration(color: Colors.grey[700]?.withOpacity(0.6)),
          ),
          Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: ListTile(                
                title: Text(style: const TextStyle(color: Colors.white, fontSize: 18), recipe.title!),
                subtitle: Text(style: const TextStyle(color: Colors.white, fontSize: 14),recipe.category!),
                trailing: IconButton(
                  onPressed: () {
                    onDelete();                  
                }, 
                icon: const Icon(Icons.delete, color: Colors.white,)),
              ),
            ),
          ],
        )],
      ),
    );
  }
}
