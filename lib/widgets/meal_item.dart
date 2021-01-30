import 'package:GaMeals/screens/meal_details_screen.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function deleteMeal;

  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.deleteMeal,
  });

  void showDetails(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(
      MealDetailsScreen.routeName,
      arguments: id,
    )
        .then((mealId) {
      if (mealId != null) {
        deleteMeal(mealId);
        Navigator.of(ctx).pushReplacementNamed('/');
      }
    });
  }

  get getComplexity {
    switch (complexity) {
      case Complexity.Easy:
        return {'icon': Icons.work_outline, 'text': 'Easy'};
      case Complexity.Medium:
        return {'icon': Icons.work, 'text': 'Medium'};
      case Complexity.Hard:
        return {'icon': Icons.work_off, 'text': 'Hard'};
      default:
        return {'icon': Icons.work_rounded, 'text': 'Unknown'};
    }
  }

  get getAffordability {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Pricey:
        return 'Pricey';
      case Affordability.Luxurious:
        return 'Expensive';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDetails(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.all(10),
        elevation: 5,
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(width: 6),
                      Text('$duration'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(getComplexity['icon']),
                      SizedBox(width: 6),
                      Text(getComplexity['text']),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(width: 6),
                      Text(getAffordability),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
