import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zdor_app/models/recipe.dart';
import 'package:zdor_app/widgets/style/constant.dart';

class ModifyRecipe extends StatefulWidget {
  final Recipe? recipe;
  final ValueSetter<Recipe> onSave;

  ModifyRecipe({Key? key, this.recipe, required this.onSave}) : super(key: key);

  @override
  _ModifyRecipeState createState() => _ModifyRecipeState();
}

class _ModifyRecipeState extends State<ModifyRecipe> {
  String? _title;
  String? _category;
  String? _prepTime;
  String? _ingredients;
  String? _procedure;
  File? _imageFile;
  late String _imagePath; // Definisci imagePath come variabile di istanza

  @override
  void initState() {
    super.initState();
    _title = widget.recipe?.title ?? '';
    _category = widget.recipe?.category ?? '';
    _prepTime = widget.recipe?.prep_time ?? '';
    _ingredients = widget.recipe?.ingredients_list != null ? widget.recipe!.ingredients_list!.join('\n') : '';
    _procedure = widget.recipe?.procedure ?? '';
  }

  // Funzione per selezionare un'immagine dalla galleria
Future<XFile?> _pickImage() async {
  // Scegli un'immagine dalla galleria usando ImagePicker
  final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);    

  // Se un'immagine è stata scelta
  if (pickedImage != null) {
    // Ottieni la directory temporanea del dispositivo
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;

    // Crea un oggetto File dall'immagine scelta
    final tempImageFile = File(pickedImage.path);

    // Costruisci il percorso completo per il nuovo file nella directory temporanea
    _imagePath = '$tempPath/${pickedImage.path.split('/').last}';

    // Copia l'immagine selezionata nella directory temporanea con lo stesso nome
    final newImage = await tempImageFile.copy(_imagePath);

    // Imposta lo stato dell'immagine per visualizzare l'immagine selezionata
    setState(() {
      _imageFile = newImage;
    });

    // Verifica se il file esiste nella directory temporanea
    bool fileExists = File(_imagePath).existsSync();
    print('Il file esiste? $fileExists');
  }
  return pickedImage;
}


  String imageChoose (String path1) {
    var list = path1.split('/');
    var  index = list.length -1;
    String name = list[index];  
    var path = "assets/image_recipes/$name";
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        backgroundColor: kBlackColor,
        title: widget.recipe != null ? const Text('Modifica Ricetta', style: TextStyle(color: kWhiteColor)) : const Text('Nuova Ricetta', style: TextStyle(color: kWhiteColor)),
        shape: const Border(
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
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [  
              // Mostra l'anteprima dell'immagine o un contenitore vuoto
              _imageFile != null
                ? Image.asset(imageChoose(_imagePath))
                : widget.recipe?.image != null
                  ? Image.asset(widget.recipe!.image!)
                  : Container(),
              // imageChoose(widget.recipe!.image!, _imageFile!), 
              const SizedBox(height: 10),
              // Bottone per selezionare un'immagine dalla galleria
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kWhiteColor),
                ),
                onPressed: () async {
                  var file = await _pickImage();                 
                } ,
                child: const Text('Seleziona Immagine', style: TextStyle(color: kBlackColor)),
              ),
              const SizedBox(height: 10),
              // Campo per il titolo della ricetta
              TextFormField(
                style: const TextStyle(color: kWhiteColor),
                initialValue: _title, 
                onChanged: (value) {    
                  _title = value;                                                       
                },
                decoration: const InputDecoration(labelText: 'Titolo', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
              ),
              const SizedBox(height: 10),
              // Campo per la categoria della ricetta
              TextFormField(
                style: const TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _category,
                onChanged: (value) {
                  _category = value;
                },
                decoration: const InputDecoration(labelText: 'Categoria', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
              ),
              const SizedBox(height: 10),
              // Campo per il tempo di preparazione della ricetta
              TextFormField(
                style: const TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _prepTime,
                onChanged: (value) {  
                  _prepTime = value;                
                },
                decoration: const InputDecoration(labelText: 'Tempo', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
              ),
              const SizedBox(height: 10),
              // Campo per gli ingredienti della ricetta
              TextFormField(
                style: const TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _ingredients,
                onChanged: (value) {     
                  _ingredients = value;            
                },
                decoration: const InputDecoration(labelText: 'Ingredienti', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
                maxLines: null,
              ),
              const SizedBox(height: 10),
              // Campo per il procedimento della ricetta
              TextFormField(
                style: const TextStyle(color: kWhiteColor, fontSize: 18),
                initialValue: _procedure,
                onChanged: (value) {  
                  _procedure = value;                 
                },
                decoration: const InputDecoration(labelText: 'Procedimento', labelStyle: TextStyle(color: kWhiteColor, fontSize: 18)),
                maxLines: null,
              ),
              const SizedBox(height: 20),
              // Bottone per salvare le modifiche
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kWhiteColor),
                ),
                onPressed: () {
                  final newIngredientList = _ingredients!.split("\n");

                  final newRecipe = Recipe(
                    id: widget.recipe?.id,
                    title: _title,
                    category: _category,
                    image: _imageFile != null ? imageChoose(_imagePath) : widget.recipe?.image,
                    ingredients_list: newIngredientList,
                    prep_time: _prepTime,
                    procedure: _procedure
                  );

                  //Callback di salvataggio
                  widget.onSave(newRecipe);

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