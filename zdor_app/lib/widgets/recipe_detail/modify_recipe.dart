import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/states/recipe_state.dart';
import 'package:zdor_app/widgets/recipe_detail/recipe_detail.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/widgets/style/constant.dart';



//------Callback non ancora funzionante---------

class ModifyRecipe extends StatelessWidget {
  late String? _title;
  late String? _category;
  late String? _prepTime;
  late String? _ingredients;
  late String? _procedure;
  File? _imageFile;
  final Recipe? recipe;
  final ValueSetter<Recipe> onSave; 

  ModifyRecipe({super.key, this.recipe, required this.onSave});

  // Funzione per selezionare un'immagine dalla galleria
  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);    
    if (pickedImage != null) {
      _imageFile = File(pickedImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<RecipeState>();

    // Utilizza il valore della ricetta solo se non è null
    _title =  recipe?.title ?? '';
    _category =  recipe?.category ?? '';
    _prepTime =  recipe?.prep_time ?? '';
    _ingredients =  recipe?.ingredients_list != null ? recipe?.ingredients_list!.join('\n') : '';
    _procedure =  recipe?.procedure ?? '';

    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        backgroundColor: kBlackColor,
        title: recipe != null ? Text('Modifica Ricetta', style: TextStyle(color: kWhiteColor)) : Text('Nuova Ricetta', style: TextStyle(color: kWhiteColor)),
        shape: Border(
            bottom: BorderSide(
                color: kWhiteColor,
                width: 1
            )
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: kWhiteColor,),
              onPressed: () {
                Navigator.pop(context);  //Return to previous screen
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [              
              _imageFile != null
                ? Image.file(_imageFile!)
                : recipe?.image != null
                  ? Image.asset(recipe!.image!) // Utilizza ! per garantire che widget.recipe non sia null.
                  : Container(),
              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kWhiteColor),
                ),
                onPressed: _pickImage,
                child: Text('Seleziona Immagine', style: TextStyle(color: kBlackColor)),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: kWhiteColor),
                initialValue: _title,
                onChanged: (value) {                  
                  _title = value;                                                       
                },
                decoration: InputDecoration(labelText: 'Titolo', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _category,
                onChanged: (value) { 
                  _category = value;
                },
                decoration: InputDecoration(labelText: 'Categoria', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _prepTime,
                onChanged: (value) {                 
                  _prepTime = value;                
                },
                decoration: InputDecoration(labelText: 'Tempo', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _ingredients,
                onChanged: (value) {                
                  _ingredients = value;            
                },
                decoration: InputDecoration(labelText: 'Ingredienti', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
                maxLines: null,
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _procedure,
                onChanged: (value) {          
                  _procedure = value;                 
                },
                decoration: InputDecoration(labelText: 'Procedimento', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
                maxLines: null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kWhiteColor),
                ),
                onPressed: () {
                  final newIngredientList = _ingredients!.split("\n");

                  // Creo la nuova ricetta con i valori inseriti   
                  final newRecipe = Recipe(
                    id: recipe?.id,
                    title: _title,
                    category: _category,
                    image: _imageFile != null ? _imageFile!.path.toString() : recipe?.image,
                    ingredients_list: newIngredientList,
                    prep_time: _prepTime,
                    procedure: _procedure
                  );

                  //Callback di salvataggio
                  onSave(newRecipe);
                  // state.saveRecipe(newRecipe);
                  
                  // Torna alla schermata precedente
                  Navigator.pop(context);
                },
                child: Text('Salva', style: TextStyle(color: kBlackColor, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ImageContainer extends StatelessWidget {
//   const ImageContainer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.7),
//                   offset: const Offset(0.0, 10.0),
//                   blurRadius: 10.0,
//                   spreadRadius: -6.0,
//                 )
//               ],
//               image: DecorationImage(
//                 image: (_imageFile != null
//                   ? FileImage(_imageFile!)
//                   : AssetImage(recipe!.image != null ? recipe!.image! : "assets/image_recipes/no_image.jpg")) as ImageProvider,
//                   fit: BoxFit.cover,
//                 ),                   
//               ),
//           );
//   }
// }
