import 'package:flutter/material.dart';
import 'package:food_deliver_app/data/category_data.dart';
import 'package:food_deliver_app/src/models/category_model.dart';
import 'package:food_deliver_app/src/widgets/food_card.dart';

class FoodCategory extends StatelessWidget {

  final List<Category> _categories = categories;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index){
          return FoodCard(
            categoryName: _categories[index].categoryName,
            imagePath: _categories[index].imagePath,
            numberOfItem: _categories[index].numberOfItems,
          );
        },
      ),
    );
  }
}
