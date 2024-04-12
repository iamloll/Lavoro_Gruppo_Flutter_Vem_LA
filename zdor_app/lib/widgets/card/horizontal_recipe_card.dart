
import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/screens/recipe_detail_screen.dart';
import 'package:zdor_app/widgets/style/constant.dart';

class RecipeCardHorizontal extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback? onToggleFavorite;

  RecipeCardHorizontal({required this.recipe, this.onToggleFavorite});

  @override
  State<RecipeCardHorizontal> createState() => _RecipeCardHorizontalState();
}

class _RecipeCardHorizontalState extends State<RecipeCardHorizontal> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: widget.recipe),
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
            image: AssetImage(widget.recipe.image ?? ''),
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
                icon: widget.recipe.isFavourite == "true" ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border, color:kOrangeColor),
                onPressed: () {
                  setState(() {
                    widget.recipe.isFavourite = widget.recipe.isFavourite == "false"? "true" : "false";
                  });
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
                      widget.recipe.prep_time ?? '',
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
                  widget.recipe.title ?? '',
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
