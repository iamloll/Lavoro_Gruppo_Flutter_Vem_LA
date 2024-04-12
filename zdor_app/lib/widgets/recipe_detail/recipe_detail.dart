import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/widgets/style/constant.dart';
import 'package:zdor_app/widgets/recipe_detail/modify_recipe.dart';



//------I valori modificati non vengono ancora aggiornati---------


class RecipeDetail extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetail({
    Key? key,
    required this.recipe,
  }) : super(key: key); 

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {

  // @override
  // void initState() {
  //   super.initState();
  //   //_updateRecipe();
  //   String? _title;
  //   String? _category;
  //   String? _prepTime;
  //   String? _ingredients;
  //   String? _procedure;
  //   //File? _imageFile;
    
  //   widget.recipe.category = _category;
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      constraints: BoxConstraints(maxHeight: 250),
                      child: Image.asset(
                        widget.recipe.image!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Categoria:", style: TextStyle(color: kWhiteColor)),
                      SizedBox(height: 5),
                      Text(widget.recipe.category ?? '', style: TextStyle(color: kWhiteColor, fontSize: 18)),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tempo:", style: TextStyle(color: kWhiteColor)),
                      SizedBox(height: 5),
                      Text(widget.recipe.prep_time ?? '', style: TextStyle(color: kWhiteColor, fontSize: 18)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ingredienti:", style: TextStyle(color: kWhiteColor)),
                SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.recipe.ingredients_list?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      '- ${widget.recipe.ingredients_list?[index] ?? ''}',
                      style: TextStyle(color: kWhiteColor, fontSize: 18),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Procedimento:", style: TextStyle(color: kWhiteColor)),
                SizedBox(height: 5),
                Text(
                  widget.recipe.procedure ?? '',
                  style: TextStyle(color: kWhiteColor, fontSize: 18),
                  softWrap: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
