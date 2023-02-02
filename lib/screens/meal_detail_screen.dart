import 'package:flutter/material.dart';
import '../dummy_dart.dart';

class MealDetailScreen extends StatelessWidget {

  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;
  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext context, String title){

    return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(title, style: Theme.of(context).textTheme.headline6),
        );
  }

  Widget buildContainer(Widget child){

    return Container(
          decoration: BoxDecoration(
            color: Colors.white, 
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          height: 200, width: 365,
          child: child,
    );
  }

  @override
  Widget build(BuildContext context) {

    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id ==  mealId);
    
    return Scaffold(
      appBar: AppBar(title: Text('${selectedMeal.title}'), backgroundColor: Theme.of(context).primaryColor),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            height: 300, width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl, fit: 
              BoxFit.cover,
            ),
          ),
          SizedBox(height: 6),
          buildSectionTitle(context, 'Ingredients'),
          buildContainer(
            ListView.builder(
              itemBuilder: (ctx, index) => Card(
                color: /* Theme.of(context).accentColor */ Color.fromARGB(255, 221, 220, 220),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(selectedMeal.ingredients[index], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ),
              ),
              itemCount: selectedMeal.ingredients.length,
            ),
          ),
          buildSectionTitle(context, 'Steps'),
          buildContainer(
            ListView.builder(
              itemBuilder: (ctx, index) => Column(
                children: [ListTile(
                  leading: CircleAvatar(child: Text('#${(index+1)}'),),
                  title: Text(selectedMeal.steps[index]),
                ), Divider(),],
              ),
              itemCount: selectedMeal.steps.length,
            ),
          ),
        ],),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border), 
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}