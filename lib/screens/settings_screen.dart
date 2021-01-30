import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class SettingScreen extends StatefulWidget {
  static String routeName = '/filters';

  final bool _currentTheme;
  final Function _switchTheme;
  final Function _saveFilters;
  final Map<String, bool> _currentFilters;

  SettingScreen(
    this._currentFilters,
    this._saveFilters,
    this._currentTheme,
    this._switchTheme,
  );

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _vegan = false;
  bool _vegetarian = false;
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _theme = false;

  @override
  void initState() {
    super.initState();
    _vegan = widget._currentFilters['vegan'];
    _vegetarian = widget._currentFilters['vegetarian'];
    _glutenFree = widget._currentFilters['gluten'];
    _lactoseFree = widget._currentFilters['lactose'];
    _theme = widget._currentTheme;
  }

  Widget _buildSwitchListTile(
      String title, String subtitle, bool currentValue, Function update) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.headline4,
      ),
      value: currentValue,
      onChanged: update,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: [
          IconButton(
            alignment: Alignment.center,
            iconSize: 30,
            icon: Icon(Icons.save),
            onPressed: () => widget._saveFilters({
              'vegan': _vegan,
              'vegetarian': _vegetarian,
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
            }),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            child: Text(
              "Filter your meals then Save",
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 25,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: EdgeInsets.all(20),
          ),
          Container(
            height: 300,
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
            ),
          ),
          Container(
            child: Text(
              "Choose your theme",
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 25,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: EdgeInsets.all(20),
          ),
          Container(
            height: 300,
            child: ListView(
              children: [
                _buildSwitchListTile(
                  _theme ? 'Dark' : 'Light',
                  _theme ? '🌞 Go in Light' : '🌚 Go in dark',
                  _theme,
                  (newTheme) => setState(() {
                    _theme = newTheme;
                    widget._switchTheme(newTheme);
                  }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
