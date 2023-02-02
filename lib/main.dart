import 'package:flutter/material.dart';
import './dummy_dart.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  //default values of filters which will change on calling _setFilters
  Map<String, bool> _filters = {
    'gluten' : false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian' : false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;       //default list of meals to be shown(basically w/o filters)
  List<Meal> _favoriteMeals = [];                //at default, we don't have any favorite meals

  //calling this function from filters_screen after setting the filters 
  //and dynamically changing filter values & available meals
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      //for filtering, we pass a function to where, 
      //which receives every 'meal', 
      //& then has to return 'true' if we wanna keep it & 'false' if we wanna drop it
      _availableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if(_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  //logic to add/remove meals to/from favorites page
  void _toggleFavorite(String mealId){

    //following statement returns the index if in the list of favorite meals, the condn is met (default = -1)
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if(existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
    else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id){

    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zomato Ultra Pro Max',
      theme: ThemeData(
        primaryColor: Colors.pink,
        accentColor: Color.fromARGB(255, 255, 170, 0),
        canvasColor: Color.fromARGB(242, 250, 240, 247),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(fontSize: 20, fontFamily: 'Raleway', fontWeight: FontWeight.bold),
          bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
        ),
      ),
      //home: TabsScreen(),
      initialRoute: '/',
      routes: {
        '/' : (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName : (ctx) => CategoryMealsScreen(_availableMeals), 
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
    );
  }
}
