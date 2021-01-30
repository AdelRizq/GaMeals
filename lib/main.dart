import 'package:GaMeals/dummy_data.dart';
import 'package:flutter/material.dart';

import './screens/tabs_screen.dart';
import 'screens/settings_screen.dart';
import './screens/categories_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/category_meals_screen.dart';

import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  bool isDarkTheme = false;

  List<String> favoritedMealsIds = [];
  List<Meal> existedMeals = DUMMY_MEALS.toList();

  List<Meal> filteredMeals;

  Map<String, bool> filters = {
    'vegan': false,
    'vegetarian': false,
    'gluten': false,
    'lactose': false,
  };

  static final Map<String, Object> lightTheme = {
    'primary': Colors.pink,
    'accent': Colors.amber[400],
    'canvas': Color.fromRGBO(253, 246, 197, 1),
    'bodyText': Color.fromRGBO(253, 246, 197, 1),
    'headline6': Color.fromRGBO(60, 63, 66, 1),
    'headline4': Color.fromRGBO(90, 93, 96, 1),
  };

  static final Map<String, Object> darkTheme = {
    'primary': Colors.pink,
    'accent': Colors.amber[100],
    'canvas': Color.fromRGBO(50, 53, 56, 1),
    'bodyText': Color.fromRGBO(50, 53, 56, 1),
    'headline6': Color.fromRGBO(253, 246, 197, 1),
    'headline4': Color.fromRGBO(253, 246, 197, 1),
  };

  Map<String, Object> currentTheme = lightTheme;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    widget.filteredMeals = widget.existedMeals;
  }

  void saveFilters(Map<String, bool> newFilters) {
    setState(() {
      widget.filters = newFilters;
      widget.filteredMeals = widget.existedMeals.where((meal) {
        if ((widget.filters['vegan'] && !meal.isVegan) ||
            (widget.filters['vegetarian'] && !meal.isVegetarian) ||
            (widget.filters['gluten'] && !meal.isGlutenFree) ||
            (widget.filters['lactose'] && !meal.isLactoseFree)) return false;
        return true;
      }).toList();
      // TODO: Update favortied meals
    });
  }

  void switchTheme(bool isDarkTheme) {
    setState(() {
      widget.isDarkTheme = isDarkTheme;
      if (isDarkTheme == false) {
        widget.currentTheme = MyApp.lightTheme;
      } else {
        widget.currentTheme = MyApp.darkTheme;
      }
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: widget.currentTheme['primary'],
        accentColor: widget.currentTheme['accent'],
        canvasColor: widget.currentTheme['canvas'],
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
                color: widget.currentTheme['bodyText'],
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
                color: widget.currentTheme['headline6'],
              ),
              headline4: TextStyle(
                fontSize: 14,
                fontFamily: 'RobotoCondensed',
                color: widget.currentTheme['headline4'],
              ),
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (_) => TabsScreen(widget.favoritedMealsIds, _deleteMeal),
        CategoriesScreen.routeName: (_) => CategoriesScreen(),
        MealDetailsScreen.routeName: (_) =>
            MealDetailsScreen(_toggleFavorite, _isFavorite),
        SettingScreen.routeName: (_) => SettingScreen(
            widget.filters, saveFilters, widget.isDarkTheme, switchTheme),
        CategoryMealsScreen.routeName: (_) =>
            CategoryMealsScreen(widget.filteredMeals, _deleteMeal),
      },
    );
  }
}
