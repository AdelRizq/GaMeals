import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
      BuildContext ctx, String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(ctx).primaryColor,
      ),
      title: Text(title, style: Theme.of(ctx).textTheme.headline6),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            color: Theme.of(context).accentColor,
            alignment: Alignment.center,
            child: Text(
              'GaMeals',
              style: TextStyle(
                fontSize: 36,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          buildListTile(
            context,
            'Categories',
            Icons.restaurant,
            () => Navigator.pushReplacementNamed(context, '/'),
          ),
          buildListTile(
            context,
            'Settings',
            Icons.settings,
            () => Navigator.pushReplacementNamed(context, '/filters'),
          ),
        ],
      ),
    );
  }
}
