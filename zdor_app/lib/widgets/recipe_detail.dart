//import 'package:accordion/accordion.dart';
//import 'package:accordion/controllers.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:flutter/material.dart';
//import 'package:zdor_app/widgets/recipe_detail_screen.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({
    Key? key,
    //required this.r,
  });

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  final recipesList = RecipesService().getRecipes(results: 10).toList();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [

            //Row with placeholder recipe image
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0), // Imposta il raggio dell'arco degli angoli
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),

            //Column with recipe category type:
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Categoria:")],
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(recipesList[1].category!)],
                ),
              ],
            ),
            SizedBox(height: 20,),

            //Column with the ingredient list
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ingredienti:"),
                SizedBox(height: 5),

                // ListView for showing every ingredient in a different line
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: recipesList[1].ingredients_list!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      '- ${recipesList[1].ingredients_list![index]}',
                      style: TextStyle(fontSize: 14),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20,),

            //Recipe procedure
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Procedimento:"),
                SizedBox(height: 5),

                // Expanded to avoid horizontal overflow of text
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        recipesList[1].procedure!,
                        softWrap: true, //Enable wrapping of text
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}