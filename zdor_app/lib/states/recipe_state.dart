import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/services/recipes_service.dart';

//Imposto uno stato dove definisco i metodi con cui andrò a manipolare le ricette
class RecipeState extends ChangeNotifier {
  late List<Recipe> _recipes;

  RecipeState() {
    //Ottengo la lista iniziale privata di tutte le ricette
    _recipes = RecipesService().getRecipes(results: 30).toList();
  }

  //Creo un getter per accedere esternamente alla lista completa di ricette
  UnmodifiableListView<Recipe> get recipes => UnmodifiableListView(_recipes);

  //Creare o modificare una ricetta
  Recipe saveRecipe(Recipe recipe) {
    //Definisco un indice per le ricette non esistenti
    final incrementMaxIndex = (_recipes.length + 1).toString();
    late Recipe newRecipe;

    //Controllo se la ricetta che devo salvare esiste già
    final oldRecipe = _recipes
          .firstWhere((element) => element.id == recipe.id, orElse: () => Recipe());

    if (oldRecipe.id != null) {
      //Se esiste la modifico assegnandogli i valori che mi sono stati passati come paramentro
      final index = _recipes.indexOf(oldRecipe); //Cerco l'inidice della ricetta che sto modificando
      newRecipe = oldRecipe.copyWith(
        title: recipe.title,
        category: recipe.category,
        image: recipe.image ?? "assets/image_recipes/no_image.jpg", // Se non ha un immagine imposto una immagine vuota dagli asset
        ingredients_list: recipe.ingredients_list,
        procedure: recipe.procedure,
        prep_time: recipe.prep_time,
        isFavourite: recipe.isFavourite ?? "false"              
      );
      //Rimuovo la vecchia ricetta
      _recipes.removeWhere((element) => element.id == recipe.id);
      //Aggiungo la nuova ricetta all'indice di quella appena eliminata
      _recipes.insert(index, newRecipe);
    } else {
      //Se non esiste già ne creo una nuova a cui assegno i valori che mi sono stati passati come parametro
      newRecipe = Recipe(
          id: incrementMaxIndex,
          title: recipe.title,
          category: recipe.category,
          image: recipe.image ?? "assets/image_recipes/no_image.jpg", // Se non ha un immagine imposto una immagine vuota dagli asset
          ingredients_list: recipe.ingredients_list,
          procedure: recipe.procedure,
          prep_time: recipe.prep_time,
          isFavourite: recipe.isFavourite ?? "true");
      //Aggiungo la nuova ricetta alla lista totale delle ricette
      _recipes.add(newRecipe);
    }    
    //Metto un listener in ascolto per reagire alle modifiche appena apportate    
    notifyListeners();
    //Ritorno la nuova ricetta salvata
    return newRecipe;
  }

  //Modifico il flag isFavourite di una ricetta
  void setFavourite(Recipe recipe, {bool isFavourite = false}) {
    final String boolString = isFavourite.toString();
    final r = _recipes
        .firstWhere((element) => element.id == recipe.id)
        .copyWith(isFavourite: boolString);
    saveRecipe(r);
  }
}

//Metodi aggiuntivi eseguibili su qualsiasi lista di Recipe
extension RecipesGetter on List<Recipe> {

  //Ottenere una ricetta dato il suo id
  Recipe getRecipeById(int id) {
    //Come lista iniziale su cui lavorare uso la lista completa di ricette presente nello stato
    final initialList = this;

    final Recipe recipe = initialList.firstWhere((r) => int.parse(r.id!) == id);

    return recipe;
  }

  //Ottenere una ricetta nel cui titolo è presente il parametro passato
  List<Recipe> getRecipeByInput(String query) {
    //Come lista iniziale su cui lavorare uso la lista completa di ricette presente nello stato
    final initialList = this;

    final List<Recipe> recipes = initialList.where((r) {
      //Imposto il titolo della ricetta come tutto minuscolo per evitare errori di battitura
      final String lowerTitle = r.title!.toLowerCase();
      return lowerTitle.contains(query);
    }).toList();

    return recipes;
  }

  //Ottenere la lista di ricette con flag isFavourite == "true"
  List<Recipe> getFavouriteRecipes() {
    //Come lista iniziale su cui lavorare uso la lista completa di ricette presente nello stato
    final initialList = this;

    final List<Recipe> favourite = initialList.where((e) {
      return e.isFavourite == 'true';
    }).toList();

    return favourite;
  }

  //Ottenere una lista di tutte le categorie presenti nel json di ricette
  List<String> getCategories() {
    //Come lista iniziale su cui lavorare uso la lista completa di ricette presente nello stato
    final initialList = this;
    final List<String> catList = [];

    final cat = initialList.map((e) {
      if (!catList.contains(e.category)) {
        catList.add(e.category!);
      }
    }).toList();

    return catList;
  }

  //Ottenere una lista di ricette della categoria passata come parametro
  List<Recipe> getByCategory(String? category) {
    //Come lista iniziale su cui lavorare uso la lista completa di ricette presente nello stato
    final initialList = this;

    if(category == null) {
      return initialList;
    }

    return initialList.where((element) => element.category == category).toList();
  }
}