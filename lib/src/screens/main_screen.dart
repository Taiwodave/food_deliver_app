import 'package:flutter/material.dart';
import 'package:food_deliver_app/src/admin/add_food_item.dart';
import 'package:food_deliver_app/src/pages/explore_page.dart';
import 'package:food_deliver_app/src/pages/home_page.dart';
import 'package:food_deliver_app/src/pages/order_page.dart';
import 'package:food_deliver_app/src/pages/profile_page.dart';
import 'package:food_deliver_app/src/scope_model/main_model.dart';

class MainScreen extends StatefulWidget {
  final MainModel model;

  MainScreen({this.model});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;

  List<Widget> pages;
  Widget currentPage;

  //Pages
  HomePage homePage;
  OrderPage orderPage;
  FavoritePage favoritePage;
  ProfilePage profilePage;

  @override
  void initState() {
//    widget.foodModel.fecthFoods();

//    widget.model.fecthFoods();

    homePage = HomePage();
    orderPage = OrderPage();
    favoritePage = FavoritePage(model: widget.model);
    profilePage = ProfilePage();
    pages = [homePage, favoritePage, orderPage, profilePage];

    currentPage = homePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            currentTabIndex == 0
                ? "Food App"
                : currentTabIndex == 1
                    ? "All Food Items"
                    : currentTabIndex == 2 ? "Orders" : "Profile",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.notifications_none,
                    color: Theme.of(context).primaryColor),
                onPressed: () {}),
            IconButton(icon: _buldShoppingCart(), onPressed: () {})
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AddFoodItem()));
                },
                leading: Icon(Icons.list),
                title: Text(
                  "Add Food Item",
                  style: TextStyle(fontSize: 16.0),
                ),
              )
            ],
          ),
        ),
        resizeToAvoidBottomPadding: false,
        bottomNavigationBar: Material(
          elevation: 5.0,
          child: BottomNavigationBar(
              onTap: (int index) {
                setState(() {
                  currentTabIndex = index;
                  currentPage = pages[index];
                });
              },
              currentIndex: currentTabIndex,
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Home"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore),
                  title: Text("Explore"),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), title: Text("Order")),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text("Profile"),
                ),
              ]),
        ),
        body: currentPage,
      ),
    );
  }

  Widget _buldShoppingCart() {
    return Stack(
      children: <Widget>[
        Icon(Icons.shopping_cart, color: Theme.of(context).primaryColor),
        Positioned(
          top: 0.0,
          right: 0.0,
          child: Container(
            height: 12.0,
            width: 12.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0), color: Colors.red),
                child: Center(child: Text("1", style: TextStyle(color: Colors.white, fontSize: 12.0)),),
          ),
        )
      ],
    );
  }
}
