import 'package:flutter/material.dart';
import 'package:jeje_mall5/apis/models/listOfProductItem.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Item> _wishlistItems = [];

  List<Item> get wishlistItems => _wishlistItems;

  void addToWishlist(Item item) {
    if (!_wishlistItems.contains(item)) {
      _wishlistItems.add(item);
      notifyListeners();
    } else {
      // Item is already in the wishlist, show a prompt
      throw Exception('Item is already in your wishlist');
    }
  }

  void removeFromWishlist(Item item) {
    _wishlistItems.remove(item);
    notifyListeners();
  }
}
