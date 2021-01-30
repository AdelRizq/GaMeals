import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

import './favorites_screen.dart';
import './categories_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<String> _favoritedMeals;
  final Function _deleteMeal;

  TabsScreen(this._favoritedMeals, this._deleteMeal);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      {
        'body': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'body': FavoritesScreen(widget._favoritedMeals, widget._deleteMeal),
        'title': 'Favorites',
      },
    ];
  }

  int screenIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[screenIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _screens[screenIndex]['body'],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        currentIndex: screenIndex,
        onTap: _selectScreen,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
