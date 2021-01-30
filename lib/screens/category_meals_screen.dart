import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static final routeName = '/category-meals';

  List<Meal> _meals;
  final Function _deleteMeal;
  CategoryMealsScreen(this._meals, this._deleteMeal);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> categoryMeals;
  bool _initialLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialLoading) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;

      final String categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      categoryMeals = widget._meals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();

      _initialLoading = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title,
            imageUrl: categoryMeals[index].imageUrl,
            duration: categoryMeals[index].duration,
            complexity: categoryMeals[index].complexity,
            affordability: categoryMeals[index].affordability,
            deleteMeal: widget._deleteMeal,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
