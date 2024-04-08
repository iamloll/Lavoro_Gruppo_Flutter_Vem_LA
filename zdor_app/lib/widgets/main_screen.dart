import 'package:flutter/material.dart';
import 'package:zdor_app/screens/home.dart';
import 'package:zdor_app/screens/saved_recipes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;

  void _navigateToPage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPageIndex,
        children: [
          Homepage(navigateToSavedRecipes: () {
            _navigateToPage(1); // Naviga alla pagina delle ricette salvate
          }),
          SavedRecipesPage(
            savedRecipesList: [], // Passa la lista vuota di ricette salvate
            onPageChanged: _navigateToPage, // Passa la funzione di navigazione a SavedRecipesPage
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: _navigateToPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Salvate',
          ),
        ],
      ),
    );
  }
}
