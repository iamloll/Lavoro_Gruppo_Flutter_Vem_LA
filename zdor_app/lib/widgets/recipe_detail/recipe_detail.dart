//import 'package:accordion/accordion.dart';
//import 'package:accordion/controllers.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:flutter/material.dart';
//import 'package:zdor_app/widgets/recipe_detail_screen.dart';
import 'package:zdor_app/widgets/style/constant.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({
    Key? key,
  });

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  final recipesList = RecipesService().getRecipes(results: 30).toList();

  @override
  Widget build(BuildContext context) {
    //Recipe example
    final selectedRecipe = recipesList[4];
    
    return Card(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [

            //Row with recipe image
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      constraints: BoxConstraints(maxHeight: 250),
                      child: Image.asset(
                        // 'https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg'
                        selectedRecipe.image!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [

                //Column with recipe category
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text("Categoria:", style: TextStyle(color: kWhiteColor))],
                      ),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(selectedRecipe.category!, style: TextStyle(color: kWhiteColor))],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),

                //Column with preparation time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text("Tempo:", style: TextStyle(color: kWhiteColor))],
                      ),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(selectedRecipe.prep_time!, style: TextStyle(color: kWhiteColor))],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),

            //Column with the ingredient list
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ingredienti:", style: TextStyle(color: kWhiteColor)),
                SizedBox(height: 5),

                // ListView for showing every ingredient in a different line
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: selectedRecipe.ingredients_list!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      '- ${selectedRecipe.ingredients_list![index]}',
                      style: TextStyle(fontSize: 14, color: kWhiteColor),
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
                Text("Procedimento:", style: TextStyle(color: kWhiteColor)),
                SizedBox(height: 5),

                // Expanded to avoid horizontal overflow of text
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        selectedRecipe.procedure!, 
                        style: TextStyle(color: kWhiteColor),
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