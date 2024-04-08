import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zdor_app/widgets/style/constant.dart';

import '../screens/modifica_lista_screen.dart';

class modifica_lista_button extends StatelessWidget {
  const modifica_lista_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: kOrangeColor, // Colore del contorno
          width: 3.0, // Spessore del contorno
        ),
      ),
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ModifyListScreen()),
          );
        },
        backgroundColor: kDarkGreyColor,
        foregroundColor: kOrangeColor,
        shape: CircleBorder(),
        child: Icon(Icons.edit, size: 30.0), // Imposta la grandezza dell'icona
      ),
    );
  }
}
