import 'package:flutter/material.dart';
import 'package:food_deliver_app/src/admin/add_food_item.dart';
import 'package:food_deliver_app/src/scope_model/food_model.dart';
import 'package:food_deliver_app/src/scope_model/main_model.dart';
import 'package:food_deliver_app/src/screens/main_screen.dart';
import 'package:scoped_model/scoped_model.dart';
class MyApp extends StatelessWidget {

  final MainModel mainModel = MainModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: mainModel,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Food Delivery App",
          theme: ThemeData(
            primaryColor: Colors.blueAccent,
          ),
          home: MainScreen(
              model: mainModel,
          ),
//        home: AddFoodItem(),
        ),
    );
  }
}
