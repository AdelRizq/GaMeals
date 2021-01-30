import 'package:GaMeals/dummy_data.dart';
import 'package:flutter/material.dart';

class MealDetailsScreen extends StatelessWidget {
  static final routeName = '/meal-details';

  final Function toggleFavorite, isFavorite;
  MealDetailsScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitleContainer(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(double height, Widget w) {
    return Container(
      height: height,
      width: 300,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: w,
    );
  }

  Widget buildTile(String text, bool condition) {
    return Container(
      height: 50,
      child: ListTile(
        title: Text(text),
        trailing: Icon(
          condition ? Icons.check : Icons.clear,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((meal) => meal.id == id);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite(id) ? Icons.star : Icons.star_border,
              size: 30,
            ),
            onPressed: () => this.toggleFavorite(meal.id),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(id),
        child: Icon(Icons.delete),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Image.network(meal.imageUrl, fit: BoxFit.fill),
            ),
            buildSectionTitleContainer(context, 'Ingredients'),
            buildContainer(
              150,
              ListView.builder(
                itemBuilder: (context, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    child: Text(meal.ingredients[index]),
                  ),
                ),
                itemCount: meal.ingredients.length,
              ),
            ),
            buildSectionTitleContainer(context, 'Steps'),
            buildContainer(
              200,
              ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(meal.steps[index]),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: meal.steps.length,
              ),
            ),
            buildSectionTitleContainer(context, 'Specs'),
            buildContainer(
              220,
              ListView(
                children: [
                  buildTile('Vegan', meal.isVegan),
                  buildTile('Vegetarian', meal.isVegetarian),
                  buildTile('Gluten free', meal.isGlutenFree),
                  buildTile('Lactose free', meal.isLactoseFree),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
