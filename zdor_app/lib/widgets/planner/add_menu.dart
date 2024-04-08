import 'package:flutter/material.dart';

class AddMenu extends StatelessWidget {
  const AddMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Aggiungi una ricetta"),
        PopupMenuButton(
          icon: const Icon(Icons.add),
          onSelected: (value) {
            if (value == 0) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const Text("Widget Nuova Ricetta");
              }));
              return;
            }
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const Text("Widget Ricerca Ricetta");
            }));
          },
          itemBuilder: (context) {
            return const [
              PopupMenuItem(
                value: 0,
                child: Text("Aggiungi nuova ricetta"),
              ),
              PopupMenuItem(
                value: 1,
                child: Text("Cerca ricetta"),
              )
            ];
          },
        )
      ],
    );
  }
}
