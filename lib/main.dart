import 'package:flutter/material.dart';
import 'package:grocery_shop/src/grocery_cart/ui/grocery_products_home.dart';

void main() => runApp(GroceryCartApp());

class GroceryCartApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Grocery Store',
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'JosefinSans',
      ),
      home: GroceryProductsHome(),
    );
  }
  
}