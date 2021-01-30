import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';

import '../models/meal.dart';

import '../dummy_data.dart';

class FavoritesScreen extends StatelessWidget {
  final List<String> _favoritedMealsIds;
  final Function _deleteMeal;

  FavoritesScreen(this._favoritedMealsIds, this._deleteMeal);

  @override
  Widget build(BuildContext context) {
    final List<Meal> _favoritedMeals = DUMMY_MEALS
        .where((meal) =>
            _favoritedMealsIds.any((favoriteId) => favoriteId == meal.id))
        .toList();

    return _favoritedMealsIds.isEmpty
        ? Center(
            child: Text("Favorites"),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(
                id: _favoritedMeals[index].id,
                title: _favoritedMeals[index].title,
                imageUrl: _favoritedMeals[index].imageUrl,
                duration: _favoritedMeals[index].duration,
                complexity: _favoritedMeals[index].complexity,
                affordability: _favoritedMeals[index].affordability,
                deleteMeal: _deleteMeal,
              );
            },
            itemCount: _favoritedMeals.length,
          );
  }
}
