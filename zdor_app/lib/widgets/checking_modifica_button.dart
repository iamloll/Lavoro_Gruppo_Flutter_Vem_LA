import 'package:flutter/material.dart';
import 'package:zdor_app/widgets/style/constant.dart';

class checking_modifica_button extends StatelessWidget {
  const checking_modifica_button();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60.0, // Larghezza del container
        height: 60.0, // Altezza del container
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Imposta la forma del contorno su cerchio
          border: Border.all(
            color: kOrangeColor, // Colore del contorno
            width: 3.0, // Spessore del contorno
          ),
        ),
        child: FloatingActionButton(
          heroTag: null,
          onPressed: () {
            // Torna alla schermata precedente (IngredientListScreen)
            Navigator.pop(context);
          },
          backgroundColor: kDarkGreyColor,
          foregroundColor: kOrangeColor,
          shape: CircleBorder(),
          child: Icon(Icons.check, size: 40.0),
        ));
  }
}
