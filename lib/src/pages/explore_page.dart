import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_deliver_app/src/models/food_model.dart';
import 'package:food_deliver_app/src/scope_model/main_model.dart';
import 'package:food_deliver_app/src/widgets/food_items_card.dart';
import 'package:food_deliver_app/src/widgets/small_button.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoritePage extends StatefulWidget {
  final MainModel model;

  FavoritePage({this.model});
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {


  @override
  void initState() {
    super.initState();
    widget.model.fecthFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model){
//            model.fecthFoods();
            List<Food> foods = model.foods;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RefreshIndicator(
                onRefresh: model.fecthFoods, //this will fetch and notify listner
                child: ListView(
                  children: foods.map((Food food) {
                    return FoodItemsCard(
                      food.name,
                      food.description,
                      food.price.toString(),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
    );
  }
}
