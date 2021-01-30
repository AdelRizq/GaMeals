import 'package:GaMeals/dummy_data.dart';
import 'package:flutter/material.dart';

import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './screens/categories_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/category_meals_screen.dart';

import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  List<String> favoritedMealsIds = [];
  List<Meal> existedMeals = DUMMY_MEALS.toList();

  List<Meal> filteredMeals;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'vegan': false,
    'vegetarian': false,
    'gluten': false,
    'lactose': false,
  };

  @override
  void initState() {
    super.initState();
    widget.filteredMeals = widget.existedMeals;
  }

  void saveFilters(Map<String, bool> newFilters) {
    setState(() {
      filters = newFilters;
      widget.filteredMeals = widget.existedMeals.where((meal) {
        if ((filters['vegan'] && !meal.isVegan) ||
            (filters['vegetarian'] && !meal.isVegetarian) ||
            (filters['gluten'] && !meal.isGlutenFree) ||
            (filters['lactose'] && !meal.isLactoseFree)) return false;
        return true;
      }).toList();
      // TODO: Update favortied meals
    });
  }

  void _toggleFavorite(String id) {
    int index = widget.favoritedMealsIds.indexWhere((mealId) => mealId == id);
    if (index >= 0) {
      setState(() {
        widget.favoritedMealsIds.removeAt(index);
      });
    } else {
      setState(() {
        widget.favoritedMealsIds
            .add(widget.filteredMeals.firstWhere((meal) => meal.id == id).id);
      });
    }
  }

  bool _isFavorite(String id) {
    return widget.favoritedMealsIds.any((mealId) => mealId == id);
  }

  void _deleteMeal(String id) {
    setState(() {
      widget.existedMeals.removeWhere((meal) => meal.id == id);
      widget.filteredMeals.removeWhere((meal) => meal.id == id);
      widget.favoritedMealsIds.removeWhere((mealId) => mealId == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GaMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(253, 246, 197, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (_) => TabsScreen(widget.favoritedMealsIds, _deleteMeal),
        CategoriesScreen.routeName: (_) => CategoriesScreen(),
        MealDetailsScreen.routeName: (_) =>
            MealDetailsScreen(_toggleFavorite, _isFavorite),
        FiltersScreen.routeName: (_) => FiltersScreen(filters, saveFilters),
        CategoryMealsScreen.routeName: (_) =>
            CategoryMealsScreen(widget.filteredMeals, _deleteMeal),
      },
    );
  }
}
