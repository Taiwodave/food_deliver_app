import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_deliver_app/src/admin/add_food_item.dart';
import 'package:food_deliver_app/src/models/food_model.dart';
import 'package:food_deliver_app/src/scope_model/main_model.dart';
import 'package:food_deliver_app/src/widgets/food_items_card.dart';
import 'package:food_deliver_app/src/widgets/show_dialog.dart';
import 'package:food_deliver_app/src/widgets/small_button.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoritePage extends StatefulWidget {
  final MainModel model;

  FavoritePage({this.model});
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

// the scaffold global key
GlobalKey<ScaffoldState> _explorePageScaffoldKey = GlobalKey();


  @override
  void initState() {
    super.initState();
    widget.model.fecthFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _explorePageScaffoldKey,
      backgroundColor: Colors.white,
      body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
//            model.fecthFoods();
          // List<Food> foods = model.foods;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: RefreshIndicator(
              onRefresh: model.fecthFoods, //this will fetch and notify listner
              child: ListView.builder(
                itemCount: model.foodLength,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      final bool response = await Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => AddFoodItem(
                            food: model.foods[index],
                          )));

                          if(response){
                            SnackBar snackBar = SnackBar(
            duration: Duration(seconds: 2),
              backgroundColor: Theme.of(context).primaryColor,
              content: Text(
                "Food item successfully updated.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ));
          _explorePageScaffoldKey.currentState.showSnackBar(snackBar);
                          }
                    },
                    onDoubleTap: (){
                      //delete food item
                      showLoadingIndicator(context, "Deleting Food item...");
                      model.deleteFood(model.foods[index].id).then((bool response) => Navigator.of(context).pop());
                    },
                    child: FoodItemsCard(
                      model.foods[index].name,
                      model.foods[index].description,
                      model.foods[index].price.toString(),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
