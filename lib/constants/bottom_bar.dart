import '../screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_screen.dart';
import '../apis/models/listOfProductItem.dart';
import 'package:jeje_mall5/jt_cart_icons.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:jeje_mall5/constants/colors.dart';
import 'package:jeje_mall5/screens/order_history.dart';
import 'package:jeje_mall5/screens/profile_screen.dart';
import 'package:jeje_mall5/constants/cart_provider.dart';
import 'package:jeje_mall5/screens/checkout_screen2.dart';







class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  List<Item> cart = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void addToCart(Item product) {
    setState(() {
      final existingItemIndex = cart.indexWhere((item) => item.id == product.id);
      if (existingItemIndex >= 0) {
        cart[existingItemIndex].quantity++;
      } else {
        cart.add(product);
      }
    });
  }

  void removeFromCart(Item product) {
    setState(() {
      final existingItemIndex = cart.indexWhere((item) => item.id == product.id);
      if (existingItemIndex >= 0) {
        cart[existingItemIndex].quantity--;
        if (cart[existingItemIndex].quantity == 0) {
          cart.removeAt(existingItemIndex);
        }
      }
    });
  }

  void updateCart() {
    setState(() {});
  }

  int getTotalCartQuantity() {
    return cart.fold(0, (total, current) => total + current.quantity);
  }

  List<Widget> _widgetOptions() {
    return [
      ProductScreen(
        cart: cart,
        addToCart: addToCart, category: '',
      ),
      CartPage(
        cart: cart,
        removeFromCart: removeFromCart,
        updateCart: updateCart,
      ),
      const CheckoutStage2(),

      const OrderHistoryScreen(), // Add WishlistScreen to the options
    ];
  }

  @override
  Widget build(BuildContext context) {
    int cartItemCount = getTotalCartQuantity();
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: Center(
        child: _widgetOptions().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: colorBgW),
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 15, top: 15),
          child: Container(
            height: 60,
            decoration: const BoxDecoration(
              color: blFa,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _onItemTapped(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        IconsaxPlusLinear.home_2,
                        color: _selectedIndex == 0 ? colorPrimary : colorBgW,
                      ),
                      if (_selectedIndex == 0)
                        Text(
                          'Home',
                          style: TextStyle(
                            color: _selectedIndex == 0 ? colorPrimary : colorBgW,
                          ),
                        ),
                    ],
                  ),
                ),
GestureDetector(
                  onTap: () => _onItemTapped(1),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            IconsaxPlusLinear.shopping_cart,
                            color: _selectedIndex == 1 ? colorPrimary : colorBgW,
                          ),
                          if (_selectedIndex == 1)
                            Text(
                              'Cart',
                              style: TextStyle(
                                color: _selectedIndex == 1 ? colorPrimary : colorBgW,
                              ),
                            ),
                        ],
                      ),
                      if (cartItemCount > 0)
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: blFa,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 18,
                              minHeight: 18,
                            ),
                            child: Text(
                              '$cartItemCount',
                              style: const TextStyle(
                                color: colorPrimary,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _onItemTapped(2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(JtCart.shopcart, size: 32,
                        color: _selectedIndex == 2 ? colorPrimary : colorBgW,
                      ),
                      if (_selectedIndex == 2)
                        Text(
                          'Checkout',
                          style: TextStyle(
                            color: _selectedIndex == 2 ? colorPrimary : colorBgW,
                          ),
                        ),
                    ],
                  ),
                ),
                              GestureDetector(
                  onTap: () => _onItemTapped(3), // Navigate to Wishlist
                  child: Stack(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            IconsaxPlusLinear.receipt_search,
                            color: _selectedIndex == 3 ? colorPrimary : colorBgW,
                          ),
                          if (_selectedIndex == 3)
                            Text(
                              'O-History',
                              style: TextStyle(
                                color: _selectedIndex == 3 ? colorPrimary : colorBgW,
                              ),
                            ),
                        ],
                      ),
                   
                    ],
                  ),
                ),
                
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
