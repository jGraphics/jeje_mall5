import 'apis/timbu_api.dart';
import 'screens/cart_screen.dart';
import 'screens/view_product.dart';
import 'screens/profile_screen.dart';
import 'screens/product_screen.dart';
import 'screens/payment_screen.dart';
import 'model/onboarding_model.dart';
import 'screens/onboarding_page.dart';
import 'screens/payment_success.dart';
import 'screens/checkout_screen2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'apis/models/onboarding_controller.dart';
import 'package:jeje_mall5/screens/wish_list.dart';
import 'package:jeje_mall5/constants/bottom_bar.dart';
import 'package:jeje_mall5/screens/order_history.dart';
import 'package:jeje_mall5/constants/cart_provider.dart';
import 'package:jeje_mall5/constants/wish_list_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TimbuApiProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OnboardingController(),
        ),
      ],
      child: MaterialApp(
        title: 'Jejelove x HNG 11',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          }),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'onboarding',
        routes: {
          'onboarding': (context) => OnboardingScreen(),
          'bnav': (context) => const BottomNav(),
          'checkout': (context) => const CheckoutSuccessPage(),
          'cart': (context) => CartPage(
                cart: const [],
                removeFromCart: (product) {},
                updateCart: () {},
              ),
          'profile': (context) => const ProfileScreen(),
          'product': (context) => ProductScreen(
                cart: const [],
                addToCart: (product) {},
                category: '',
              ),
          'products-detail': (context) => const ViewProductPage(),
          'order-history': (context) => const OrderHistoryScreen(),
          'wish-list': (context) => const WishlistScreen(wishlistItems: []),
          'checkout_stage_2': (context) => const CheckoutStage2(), // Add route for checkout stage 2
          'payment': (context) => const PaymentScreen(), // Add route for payment screen
        },
      ),
    );
  }
}
