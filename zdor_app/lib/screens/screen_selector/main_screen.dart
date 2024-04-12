import 'package:flutter/material.dart';
import 'package:zdor_app/screens/home.dart';
import 'package:zdor_app/screens/saved_recipes_screen.dart';
import 'package:zdor_app/screens/planner_screen.dart';
import 'package:zdor_app/screens/lista_spesa_screen.dart';
import 'package:zdor_app/widgets/navbar/bottom_navigation_bar.dart';

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
          Homepage(),
          SavedRecipesPage(),
          PlannerWidget(),
          IngredientListScreen(),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentPageIndex: _currentPageIndex,
        onPageChanged: _navigateToPage,
      ),
    );
  }
}
