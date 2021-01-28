import 'package:flutter/foundation.dart';

enum Complexity {
  Easy,
  Medium,
  Hard,
}

enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

class Meal {
  final String id;
  final String title;
  final String imageUrl;

  final List<String> categories;
  final List<String> ingredients;
  final List<String> steps;

  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  final bool isVegan;
  final bool isVegetarian;
  final bool isGlutenFree;
  final bool isLactoseFree;

  const Meal({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.categories,
    @required this.ingredients,
    @required this.steps,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.isVegan,
    @required this.isVegetarian,
    @required this.isGlutenFree,
    @required this.isLactoseFree,
  });
}
