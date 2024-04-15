import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/widgets/style/constant.dart';

class RecipeDetail extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetail({
    super.key,
    required this.recipe,
  }); 

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            //IMMAGINE
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 250),
                      child: Image.asset(
                        recipe.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            //CATEGORIA
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Categoria:", style: TextStyle(color: kWhiteColor)),
                      const SizedBox(height: 5),
                      Text(recipe.category ?? '', style: const TextStyle(color: kWhiteColor, fontSize: 18)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Tempo:", style: TextStyle(color: kWhiteColor)),
                      const SizedBox(height: 5),
                      Text(recipe.prep_time ?? '', style: const TextStyle(color: kWhiteColor, fontSize: 18)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            //LISTA INGREDIENTI
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Ingredienti:", style: TextStyle(color: kWhiteColor)),
                const SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: recipe.ingredients_list?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      '- ${recipe.ingredients_list?[index] ?? ''}',
                      style: const TextStyle(color: kWhiteColor, fontSize: 18),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            //pROCEDIMENTO
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Procedimento:", style: TextStyle(color: kWhiteColor)),
                const SizedBox(height: 5),
                Text(
                  recipe.procedure ?? '',
                  style: const TextStyle(color: kWhiteColor, fontSize: 18),
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
