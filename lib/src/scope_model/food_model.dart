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

  int get foodLength{
    return _foods.length;
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
            price: double.parse(foodData["price"].toString()),
            discount: double.parse(foodData["discount"].toString()));

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

  Future<bool> updateFood(Map<String, dynamic> foodData, String foodId) async {
    _isLoading = true;
    notifyListeners();

    //get the food by id
    Food thefood = getFoodItemById(foodId);

    //get theindex of the food
    int foodIndex = _foods.indexOf(thefood);
    try {
      await http.put("https://fooddeliveryapp-35515.firebaseio.com/foods/${foodId}.json", body: json.encode(foodData));  

      Food updatedFoodItem = Food(
        id: foodId,
        name: foodData["title"],
        category: foodData["category"],
        discount: foodData["discount"],
        price: foodData["price"],
        description: foodData["description"],
      );

      _foods[foodIndex] = updatedFoodItem;

      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (error) {
       _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<bool> deleteFood(String foodId) async{
    _isLoading = true;
    notifyListeners();
   try {
     final http.Response response = await http.delete("https://fooddeliveryapp-35515.firebaseio.com/foods/${foodId}.json");

     //delete item from the list of food item
     _foods.removeWhere((Food food) => food.id == foodId);


     _isLoading = false;
     notifyListeners();
     return Future.value(true);
   } catch (error) {
     _isLoading = false;
     notifyListeners();
     return Future.value(false);
   }
  }

Food getFoodItemById(String foodId){
  Food food;
  for(int i = 0; i < _foods.length; i++){
    if(_foods[i].id == foodId){
      food = _foods[i];
      break;
    }
  }
  return food;
}

}
