import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static String routeName = '/filters';

  final Function _saveFilters;
  final Map<String, bool> _currentFilters;

  FiltersScreen(this._currentFilters, this._saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _vegan = false;
  bool _vegetarian = false;
  bool _glutenFree = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    super.initState();
    _vegan = widget._currentFilters['vegan'];
    _vegetarian = widget._currentFilters['vegetarian'];
    _glutenFree = widget._currentFilters['gluten'];
    _lactoseFree = widget._currentFilters['lactose'];
  }

  Widget _buildSwitchListTile(
      String title, String subtitle, bool currentValue, Function update) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: update,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => widget._saveFilters({
              'vegan': _vegan,
              'vegetarian': _vegetarian,
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
            }),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            child: Text(
              "Filter your meals",
              style: Theme.of(context).textTheme.headline6,
            ),
            padding: EdgeInsets.all(20),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                'Vegan',
                'Include only vegan meals',
                _vegan,
                (newValue) => setState(() {
                  _vegan = newValue;
                }),
              ),
              _buildSwitchListTile(
                'Vegetarian',
                'Include only vegetarian meals',
                _vegetarian,
                (newValue) => setState(() {
                  _vegetarian = newValue;
                }),
              ),
              _buildSwitchListTile(
                'Gluten free',
                'Include only gluten-free meals',
                _glutenFree,
                (newValue) => setState(() {
                  _glutenFree = newValue;
                }),
              ),
              _buildSwitchListTile(
                'Lactose free',
                'Include only lactose-free meals',
                _lactoseFree,
                (newValue) => setState(() {
                  _lactoseFree = newValue;
                }),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
