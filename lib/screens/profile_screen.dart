import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:jeje_mall5/constants/colors.dart';
import 'package:jeje_mall5/screens/wish_list.dart';
import 'package:jeje_mall5/screens/order_history.dart';
import 'package:jeje_mall5/apis/models/listOfProductItem.dart';

class ProfileScreen extends StatelessWidget {
  final List<Item>? wishlistItems; // Declare wishlistItems as nullable

  const ProfileScreen({Key? key, this.wishlistItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBgW,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: colorBgW,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: colorBgW,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('./assets/images/hnc.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Jejelove Doe', // Replace with actual user name
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: bg,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'jejelovesolutions@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: blFa,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(IconsaxPlusLinear.receipt_item, color: colorPrimary),
              title: const Text('Order History'),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  OrderHistoryPage(orderHistory: const [],)),
                );
                // Handle navigation to order history screen
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(IconsaxPlusLinear.personalcard, color: colorPrimary),
              title: const Text('Wish List'),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                if (wishlistItems != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WishlistScreen(wishlistItems: [],)),
                  );
                } else {
                  // Handle if wishlistItems is null or undefined
                  // For example, show a snackbar or navigate to an empty wishlist screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Wishlist is empty'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
