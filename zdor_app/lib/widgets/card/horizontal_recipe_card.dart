import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/screens/recipe_detail_screen.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/widgets/style/constant.dart';



class RecipeCardHorizontal extends StatelessWidget {
  final Recipe recipe;
  final ValueSetter<Recipe> onToggleFavorite;

  RecipeCardHorizontal({required this.recipe, required this.onToggleFavorite});

  @override
  Widget build(BuildContext context) {
    final state = context.read<RecipeState>();
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailScreen(recipe: recipe),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          width: MediaQuery.of(context).size.width * 0.5,
          height: 180,
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                offset: Offset(
                  0.0,
                  10.0,
                ),
                blurRadius: 10.0,
                spreadRadius: -6.0,
              ),
            ],
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.35),
                BlendMode.multiply,
              ),
              image: AssetImage(recipe.image ?? ''),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: IconButton(
                    icon: recipe.isFavourite == "true"
                        ? Icon(Icons.favorite, color: Colors.red)
                        : Icon(Icons.favorite_border, color: kOrangeColor),
                    onPressed: () {  
                      onToggleFavorite(recipe);
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule,
                        color: kOrangeColor,
                        size: 18,
                      ),
                      SizedBox(width: 7),
                      Text(
                        recipe.prep_time ?? '',
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    recipe.title ?? '',
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 19,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    
  }
}
