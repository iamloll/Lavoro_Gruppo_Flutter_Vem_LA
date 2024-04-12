import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/services/recipes_service.dart';
import 'package:zdor_app/widgets/style/constant.dart';

class ModifyRecipe extends StatefulWidget {
  final Recipe? recipe; // Ora la ricetta può essere nullabile

  const ModifyRecipe({Key? key, this.recipe}) : super(key: key);

  @override
  State<ModifyRecipe> createState() => _ModifyRecipeState();
}


class _ModifyRecipeState extends State<ModifyRecipe> {
  String? _title;
  String? _category;
  String? _prepTime;
  String? _ingredients;
  String? _procedure;
  File? _imageFile;

  // void _updateRecipe() {
  //   setState(() {
  //     widget.recipe.title = _title ?? '';
  //     widget.recipe.category = _category ?? '';
  //     widget.recipe.prep_time = _prepTime ?? '';
  //     widget.recipe.ingredients_list = _ingredients != null ? _ingredients!.split('\n') : [];
  //     widget.recipe.procedure = _procedure ?? '';
  //     widget.recipe.image = _imageFile?.path ?? widget.recipe.image;
  //   });
  // }


  // Funzione per selezionare un'immagine dalla galleria
  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _title = widget.recipe?.title ?? ''; // Utilizza il valore della ricetta solo se non è null
    _category =  widget.recipe?.category ?? '';
    _prepTime =  widget.recipe?.prep_time ?? '';
    _ingredients =  widget.recipe?.ingredients_list != null ? widget.recipe!.ingredients_list!.join('\n') : '';
    _procedure =  widget.recipe?.procedure ?? '';

    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        backgroundColor: kBlackColor,
        title: Text('Modifica Ricetta', style: TextStyle(color: kWhiteColor)),
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
                : widget.recipe?.image != null // Utilizza l'operatore di accesso condizionale ?.
                  ? Image.asset(widget.recipe!.image!) // Utilizza il null-aware operator ! per garantire che widget.recipe non sia null.
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
                  setState(() {
                    _title = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Titolo', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _category,
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Categoria', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _prepTime,
                onChanged: (value) {
                  setState(() {
                    _prepTime = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Tempo', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _ingredients,
                onChanged: (value) {
                  setState(() {
                    _ingredients = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Ingredienti', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
                maxLines: null,
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _procedure,
                onChanged: (value) {
                  setState(() {
                    _procedure = value;
                  });
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
                  // Aggiorna la ricetta corrente con i nuovi valori
                  //_updateRecipe();
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
