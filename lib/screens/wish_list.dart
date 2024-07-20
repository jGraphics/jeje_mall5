import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeje_mall5/constants/colors.dart';
import 'package:jeje_mall5/screens/cart_screen.dart';
import 'package:jeje_mall5/constants/cart_provider.dart';
import 'package:jeje_mall5/constants/wish_list_provider.dart';
import 'package:jeje_mall5/apis/models/listOfProductItem.dart';


class WishlistScreen extends StatelessWidget {
  final List<Item> wishlistItems;

  const WishlistScreen({super.key, required this.wishlistItems});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
     final wishlistItems = wishlistProvider.wishlistItems;
    final NumberFormat currencyFormat =
        NumberFormat.currency(symbol: '₦', decimalDigits: 2);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Wishlist',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
              color: blFa,
            ),
          ),
        ),
        centerTitle: true,
       backgroundColor: colorBgW,
        iconTheme: const IconThemeData(color: blFa),
      ),
      backgroundColor: colorBgW,
     body: wishlistItems.isEmpty
          ? const Center(child: Text('Your wishlist is empty'))
          : ListView.builder(
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                final item = wishlistItems[index];
                return ListTile(
            title: Text(item.name ?? ''),
            subtitle:
                Text(currencyFormat.format(item.currentPrice?[0].ngn[0] ?? 0)),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://api.timbu.cloud/images/${item.photos[0].url}",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(IconsaxPlusLinear.message_minus),
              onPressed: () {
                wishlistProvider.removeFromWishlist(item);
                // Implement removal from wishlist functionality here
                // Example: Provider.of<WishlistProvider>(context, listen: false).removeFromWishlist(item);
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(item: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final Item item;

  const ProductDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat =
        NumberFormat.currency(symbol: '₦', decimalDigits: 2);
        final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.name ?? '',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
              color: blFa,
            ),
          ),
        ),
        backgroundColor: colorBgW,
        iconTheme: const IconThemeData(color: blFa),
      ),
      backgroundColor: colorBgW,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 240, // Adjust as per your design
              child: Image.network(
                "https://api.timbu.cloud/images/${item.photos[0].url}",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Image(image: AssetImage('assets/images/fill_star.png')),
                      Image(image: AssetImage('assets/images/fill_star.png')),
                      Image(image: AssetImage('assets/images/fill_star.png')),
                      Image(image: AssetImage('assets/images/fill_star.png')),
                      Image(image: AssetImage('assets/images/fill_star.png')),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currencyFormat.format(item.currentPrice?[0].ngn[0] ?? 0),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 307,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        cartProvider.addToCart(item);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Item added to cart'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
