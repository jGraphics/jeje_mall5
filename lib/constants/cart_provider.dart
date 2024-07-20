import 'package:flutter/material.dart';
import 'package:jeje_mall5/apis/models/listOfProductItem.dart';

class CartProvider extends ChangeNotifier {
  final List<Item> _cartItems = [];

  List<Item> get cartItems => _cartItems;

  void addToCart(Item item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(Item item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  int get cartCount => _cartItems.length;
}
