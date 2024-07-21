import 'package:flutter/material.dart';
import 'package:jeje_mall5/apis/models/listOfProductItem.dart';

class CartProvider with ChangeNotifier {
  List<Item> _cartItems = [];

  List<Item> get cartItems => _cartItems;

  void addToCart(Item item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void incrementItemQuantity(Item item) {
    item.quantity++;
    notifyListeners();
  }

  void decrementItemQuantity(Item item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _cartItems.remove(item);
    }
    notifyListeners();
  }
}