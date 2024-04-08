import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchRecipeCard extends StatelessWidget {
  final String title;
  final String category;
  final String image;
  SearchRecipeCard({
    required this.title,
    required this.category,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
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
          image: AssetImage(image),
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
                        onPressed: () => print("liked"), 
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
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
                      Flexible(child: Text(title, style: TextStyle(color: Colors.white, fontSize: 18),)),
                      Flexible(child: Text(category, style: TextStyle(color: Colors.white, fontSize: 14)))
                    ],
                  ),
                )
          ),
        ],
      ),
    );
  }
}