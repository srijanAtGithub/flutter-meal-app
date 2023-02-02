import 'package:flutter/material.dart';
import '../screens/categories_screen.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {

  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  //following values are the default values for the filter page
  bool _glutenFree = false;         //could also use 'var' instead of 'bool' as dart can infer datatype
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  //following initState is made to save the filters that were already set, 
  //(therefore, to avoid displaying the default filter values everytime we load this filter page)
  @override
  void initState() {
    // TODO: implement initState

    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description, bool currentValue, Function updateValue) {

    return SwitchListTile(
      title: Text(title), 
      subtitle: Text(description), 
      value: currentValue, 
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold (
      appBar: AppBar(
        title: Text('Your Filters'), 
        actions: <Widget>[IconButton(icon: Icon(Icons.done), onPressed: () {
          final selectedFilters = {
            'gluten' : _glutenFree,
            'lactose' : _lactoseFree,
            'vegan' : _vegan,
            'vegetarian' : _vegetarian,
          };
          widget.saveFilters(selectedFilters);
        },),],
        backgroundColor: Theme.of(context).primaryColor,),
      drawer: MainDrawer(),
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'Adjust Your Meal Selection', 
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Expanded(
          child: ListView(children: <Widget>[
            _buildSwitchListTile(
              'Gluten Free', 
              'Only Include Gluten Free Meals', 
              _glutenFree, 
              (newValue){setState(() {
                _glutenFree = newValue;
              },);}
            ),
            _buildSwitchListTile(
              'Lactose Free', 
              'Only Include Lactose Free Meals', 
              _lactoseFree, 
              (newValue){setState(() {
                _lactoseFree = newValue;
              },);}
            ),
            _buildSwitchListTile(
              'Vegetarian', 
              'Only Include Vegetarian Meals', 
              _vegetarian, 
              (newValue){setState(() {
                _vegetarian = newValue;
              },);}
            ),
            _buildSwitchListTile(
              'Vegan', 
              'Only Include Vegan Meals', 
              _vegan, 
              (newValue){setState(() {
                _vegan = newValue;
              },);}
            ),
          ],)
        )
      ]),
    ); 
  }
}