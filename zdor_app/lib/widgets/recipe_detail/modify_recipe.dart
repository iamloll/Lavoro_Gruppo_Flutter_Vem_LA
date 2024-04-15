import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/widgets/style/constant.dart';

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
    // Utilizzo il valore della ricetta se non è null
    _title =  recipe?.title ?? '';
    _category =  recipe?.category ?? '';
    _prepTime =  recipe?.prep_time ?? '';
    _ingredients =  recipe?.ingredients_list != null ? recipe?.ingredients_list!.join('\n') : ''; //Trasformo la lista ingredienti in una stringa
    _procedure =  recipe?.procedure ?? '';

    return Scaffold(
      backgroundColor: kBlackColor,
      //TITOLO RICETTA
      appBar: AppBar(
        backgroundColor: kBlackColor,
        //Visualizzo il titolo condizionalmente a seconda se la ricetta ricevuta come parametro è popolata o null
        title: recipe != null ? const Text('Modifica Ricetta', style: TextStyle(color: kWhiteColor)) : const Text('Nuova Ricetta', style: TextStyle(color: kWhiteColor)),
        shape: const Border(
            bottom: BorderSide(
                color: kWhiteColor,
                width: 1
            )
        ),
        //ICONA BACK
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: kWhiteColor,),
              onPressed: () {
                Navigator.pop(context);  //Navigo verso la schermata precedente
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      //IMMAGINE
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [  
              //Se l'immagine ottenuta alla pressione del bottone è null uso l'immagine della ricetta            
              _imageFile != null
                ? Image.file(_imageFile!)
                : recipe?.image != null
                  ? Image.asset(recipe!.image!) 
                  : Container(),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kWhiteColor),
                ),
                onPressed: _pickImage, //Funzione per ottenere un'immagine dalla galleria
                child: const Text('Seleziona Immagine', style: TextStyle(color: kBlackColor)),
              ),
              const SizedBox(height: 10),
              //TITOLO
              TextFormField(
                style: const TextStyle(color: kWhiteColor),
                initialValue: _title, 
                onChanged: (value) {    
                  //Imposto il valore della proprietà con il valore inserito in input              
                  _title = value;                                                       
                },
                decoration: const InputDecoration(labelText: 'Titolo', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
              ),
              const SizedBox(height: 10),
              //CATEGORIA
              TextFormField(
                style: const TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _category,
                onChanged: (value) {
                  //Imposto il valore della proprietà con il valore inserito in input  
                  _category = value;
                },
                decoration: const InputDecoration(labelText: 'Categoria', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
              ),
              const SizedBox(height: 10),
              //TEMPO DI PREPARAZIONE
              TextFormField(
                style: const TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _prepTime,
                onChanged: (value) {  
                  //Imposto il valore della proprietà con il valore inserito in input                
                  _prepTime = value;                
                },
                decoration: const InputDecoration(labelText: 'Tempo', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
              ),
              const SizedBox(height: 10),
              //LISTA INGREDIENTI
              TextFormField(
                style: const TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _ingredients,
                onChanged: (value) {     
                  //Imposto il valore della proprietà con il valore inserito in input            
                  _ingredients = value;            
                },
                decoration: const InputDecoration(labelText: 'Ingredienti', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
                maxLines: null,
              ),
              const SizedBox(height: 10),
              //PROCEDURA
              TextFormField(
                style: const TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _procedure,
                onChanged: (value) {  
                  //Imposto il valore della proprietà con il valore inserito in input         
                  _procedure = value;                 
                },
                decoration: const InputDecoration(labelText: 'Procedimento', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
                maxLines: null,
              ),
              const SizedBox(height: 20),
              //PULSANTE SALVA
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kWhiteColor),
                ),
                onPressed: () {
                  //Trasformo in lista la stringa di ingredienti
                  final newIngredientList = _ingredients!.split("\n");

                  // Creo la nuova ricetta con i valori inseriti   
                  final newRecipe = Recipe(
                    id: recipe?.id, //Uso l'id della ricetta passata come parametro, se non è null
                    title: _title,
                    category: _category,
                    image: _imageFile != null ? _imageFile!.path.toString() : recipe?.image, //Se la path della nuova immagine è null uso quella della ricetta
                    ingredients_list: newIngredientList,
                    prep_time: _prepTime,
                    procedure: _procedure
                  );

                  //Callback di salvataggio
                  onSave(newRecipe);
                  
                  // Torna alla schermata precedente
                  Navigator.pop(context);
                },
                child: const Text('Salva', style: TextStyle(color: kBlackColor, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}