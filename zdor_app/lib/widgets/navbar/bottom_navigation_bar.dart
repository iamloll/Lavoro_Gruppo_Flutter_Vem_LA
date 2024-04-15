import 'package:flutter/material.dart';
import 'package:zdor_app/widgets/style/constant.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentPageIndex; // Indice della pagina corrente
  final void Function(int) onPageChanged; // Funzione chiamata quando si cambia pagina

  const CustomNavigationBar({
    super.key,
    required this.currentPageIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: kBlackColor,
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Imposta il tipo di navigation bar
        elevation: 0.0, // Rimuove l'ombra sotto la barra
        selectedItemColor: kOrangeColor, // Imposta il colore degli elementi selezionati
        unselectedItemColor: Colors.white, // Imposta il colore degli elementi non selezionati
        currentIndex: currentPageIndex, // Imposta l'indice della pagina corrente
        onTap: onPageChanged, // Chiamata quando si tocca un elemento della barra
        items: const <BottomNavigationBarItem>[ // Elementi della barra di navigazione
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), // Icona per la home
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_outlined), // Icona per le ricette salvate
            label: 'Salvate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range_outlined), // Icona per il planner
            label: 'Planner', 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list), // Icona per la lista della spesa
            label: 'Lista Spesa',
          ),
        ],
      ),
    );
  }
}
