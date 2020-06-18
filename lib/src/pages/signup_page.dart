import 'package:flutter/material.dart';
import 'package:food_deliver_app/src/pages/signin_page.dart';
import 'package:food_deliver_app/src/scope_model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _toogleVisibility = true;
  // bool _toogleConfirmVisibility = true;

  String _email;
  String _username;
  String _password;
  String _confirmPassword;

  GlobalKey<FormState> _formKey = GlobalKey();

  Widget _buildUsernameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Username",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (String username) {
        _username = username.trim();
      },
      validator: (String username) {
        String errorMessage;
        if (username.isEmpty) {
          errorMessage = "Username field is required";
        }
        // if(username.length < 2){
        //   errorMessage = " Your username is too short";
        // }
        return errorMessage;
      },
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Email ",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (String email) {
        _email = email;
      },
      validator: (String email) {
        String errorMessage;
        if (!email.contains("@")) {
          errorMessage = "Your Email id Incorrect ";
        }
        if (email.isEmpty) {
          errorMessage = "Email is required";
        }

        return errorMessage;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
        suffixIcon: IconButton(
          icon: _toogleVisibility
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
          onPressed: () {
            setState(
              () {
                _toogleVisibility = !_toogleVisibility;
              },
            );
          },
        ),
      ),
      obscureText: _toogleVisibility,
      onSaved: (String password) {
        _password = password;
      },
      validator: (String password) {
        String errorMessage;
        if (password.isEmpty) {
          errorMessage = "Your pasword is required";
        }
        return errorMessage;
      },
    );
  }

  // Widget _buildConfirmPasswordTextField() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       hintText: "Confirm Password",
  //       hintStyle: TextStyle(
  //         color: Color(0xFFBDC2CB),
  //         fontSize: 18.0,
  //       ),
  //       suffixIcon: IconButton(
  //         icon: _toogleConfirmVisibility
  //             ? Icon(Icons.visibility_off)
  //             : Icon(Icons.visibility),
  //         onPressed: () {
  //           setState(() {
  //             _toogleConfirmVisibility = !_toogleConfirmVisibility;
  //           });
  //         },
  //       ),
  //     ),
  //     obscureText: _toogleConfirmVisibility,
  //     onSaved: (String value) {},
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey.shade100,
        resizeToAvoidBottomPadding: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 100.0),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        _buildUsernameTextField(),
                        SizedBox(height: 20.0),
                        _buildEmailTextField(),
                        SizedBox(height: 20.0),
                        _buildPasswordTextField(),
                        // SizedBox(height: 20.0),
                        // _buildConfirmPasswordTextField(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                _buildSignUpButton(),
                Divider(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Color(0xFFBDC2CB),
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => SignInPage()));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return ScopedModelDescendant(
      builder: (BuildContext sctx, Widget child, MainModel model){
        return GestureDetector(
      onTap: () {
        onSubmit(model.authenticate);
      },
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Center(
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
      },
    );
  }

  void onSubmit(Function authenticate) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print("The Email: $_email, the password: $_password");
      authenticate(_email, _password);
    }
  }
}
