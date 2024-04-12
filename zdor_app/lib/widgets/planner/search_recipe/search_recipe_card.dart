import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/models/meal_planner.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/screens/planner_screen.dart';
import 'package:zdor_app/states/recipe_state.dart';

class SearchRecipeCard extends StatefulWidget {
  final Recipe recipe;
  final WeekDays day;
  final Meals meal;
  
  const SearchRecipeCard({
    super.key,  
    required this.recipe,
    required this.day, 
    required this.meal
  });

  @override
  State<SearchRecipeCard> createState() => _SearchRecipeCardState();
}

class _SearchRecipeCardState extends State<SearchRecipeCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeState>(
      builder: (context, value, child) {
        return GestureDetector(          
        onTap: () {
          print("Tappato ricetta n. ${widget.recipe.id}");
          print("day --> ${widget.day} - meal --> ${widget.meal}");
          value.addRecipe(widget.day, widget.meal, int.parse(widget.recipe.id!));
          print(value.planner);
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                offset: const Offset(0.0, 10.0),
                blurRadius: 10.0,
                spreadRadius: -6.0,
              )],
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.35),
                BlendMode.multiply,
              ),
              image: AssetImage(widget.recipe.image!),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(        
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                            onPressed: () {
                              //--LIKE DA FIXARE--
                              setState(() {
                                print("favourite!");
                                widget.recipe.isFavourite == "true";
                                // widget.recipe.isFavourite == "false" ? widget.recipe.isFavourite = "true" : widget.recipe.isFavourite = "false";
                              });                              
                            }, 
                            icon: widget.recipe.isFavourite == "true"
                            ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                            : const Icon(
                              Icons.favorite_border,                              
                            )
                          )
                    )
                  ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [                      
                          Flexible(child: Text(widget.recipe.title!, style: TextStyle(color: Colors.white, fontSize: 18),)),
                          Flexible(child: Text(widget.recipe.category!, style: TextStyle(color: Colors.white, fontSize: 14)))
                        ],
                      ),
                    )
              ),
            ],
          ),
        ),
      );
      }
      // child: ,
    );
  }
}