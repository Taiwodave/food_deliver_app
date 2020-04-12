import 'dart:convert';

import 'package:food_deliver_app/src/models/food_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class FoodModel extends Model {
  List<Food> _foods = [];
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  List<Food> get foods {
    return List.from(_foods);
  }

  Future<bool> addFood(Food food) async {
    _isLoading = true;
    notifyListeners();
    try {
      //    _foods.add(food);
      final Map<String, dynamic> foodData = {
        "title": food.name,
        "description": food.description,
        "category": food.category,
        "price": food.price,
        "discount": food.discount
      };
      final http.Response response = await http.post(
          "https://fooddeliveryapp-35515.firebaseio.com/foods.json",
          body: json.encode(foodData));

      final Map<String, dynamic> responseData = json.decode(response.body);
//  print(responseData["name"]);
      Food foodWithId = Food(
          id: responseData["name"],
          name: food.name,
          description: food.description,
          category: food.category,
          discount: food.discount,
          price: food.price);

      _foods.add(foodWithId);
      _isLoading = false;
      notifyListeners();
      fecthFoods();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<bool> fecthFoods() async {
    _isLoading = true;
    notifyListeners();
    try{
      final http.Response response = await http
          .get("https://fooddeliveryapp-35515.firebaseio.com/foods.json");

      //      print("Fetching data: ${response.body}");
      final Map<String, dynamic> fetchData = json.decode(response.body);
//      print(fetchData);

      final List<Food> foodItems = [];

      fetchData.forEach((String id, dynamic foodData) {
        Food foodItem = Food(
            id: id,
            name: foodData["title"],
            description: foodData["description"],
            category: foodData["category"],
            price: foodData["price"],
            discount: foodData["discount"]);

        foodItems.add(foodItem);
      });

      _foods = foodItems;
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch(error){
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }
}
