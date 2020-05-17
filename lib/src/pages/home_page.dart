import 'package:flutter/material.dart';
import 'package:food_deliver_app/src/models/food_category.dart';
import 'package:food_deliver_app/src/models/food_model.dart';
import 'package:food_deliver_app/src/pages/food_details_page.dart';
import 'package:food_deliver_app/src/scope_model/food_model.dart';
import 'package:food_deliver_app/src/scope_model/main_model.dart';
import 'package:food_deliver_app/src/widgets/bought_foods.dart';
import 'package:food_deliver_app/src/widgets/home_top_info.dart';
import 'package:food_deliver_app/src/widgets/search_field.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
//  final FoodModel foodModel;
//
//  const HomePage({this.foodModel});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  List<Food> _foods = foods;
  @override
  void initState() {
//    widget.foodModel.fecthFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        children: <Widget>[
          HomeTopInfo(),
          FoodCategory(),
          SizedBox(height: 20.0),
          SearchField(),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Frequently Bougth Foods",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "View",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent),
                ),
              )
            ],
          ),
          SizedBox(height: 20.0),
          ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
            return Column(
              children: model.foods.map(_buildFoodItems).toList(),
            );
          })
        ],
      ),
    );
  }

  Widget _buildFoodItems(Food food) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => FoodDetailsPage(food: food,),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: BoughtFoods(
          id: food.id,
          name: food.name,
          imagePath: "assets/images/lunch.jpeg",
          category: food.category,
          discount: food.discount,
          price: food.price,
          ratings: food.ratings,
        ),
      ),
    );
  }
}
