
import 'package:food_deliver_app/src/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
class UserMoodel extends Model{
  User _authenticatedUser;

  void authenticate(String email, String password) async {

    Map <String, dynamic>  authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true,
    };
    try{
      http.Response response = await http.post("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCQR_EvmO5SBAEyk7QAPQmVP_hO7w8EXlw", body: json.encode(authData),
      headers: {'Content-Type' : 'application/json'}
      );

      print("Printing the response body : ${response.body}");
    }catch(error){
      print("This error signing up: $error");
    }
  }
}