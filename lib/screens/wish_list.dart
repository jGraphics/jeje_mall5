import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeje_mall5/constants/colors.dart';
import 'package:jeje_mall5/constants/cart_provider.dart';
import 'package:jeje_mall5/screens/checkout_screen2.dart';
import 'package:jeje_mall5/constants/wish_list_provider.dart';
import 'package:jeje_mall5/apis/models/listOfProductItem.dart';

class WishlistScreen extends StatelessWidget {
  final List<Item> wishlistItems;

  const WishlistScreen({super.key, required this.wishlistItems});

  void checkout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CheckoutStage2()),
    );
    Provider.of<CartProvider>(context, listen: false).clearCart();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cart cleared.'),
      ),
    );
  }

  void incrementQuantity(Item product, BuildContext context) {
    Provider.of<CartProvider>(context, listen: false).incrementItemQuantity(product);
  }

  void decrementQuantity(Item product, BuildContext context) {
    Provider.of<CartProvider>(context, listen: false).decrementItemQuantity(product);
  }

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItems = wishlistProvider.wishlistItems;
    final cartProvider = Provider.of<CartProvider>(context);
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
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                    'https://lottie.host/945b8558-0f5c-4792-a793-d5f13dc11611/hCCFhsPEoC.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your wishlist is empty',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                final item = wishlistItems[index];
                return ListTile(
                  title: Text(item.name ?? ''),
                  subtitle: Text(
                      currencyFormat.format(item.currentPrice?[0].ngn[0] ?? 0)),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://api.timbu.cloud/images/${item.photos[0].url}",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(IconsaxPlusLinear.trash, 
                        color: Colors.red,),
                        onPressed: () {
                          wishlistProvider.removeFromWishlist(item);
                        },
                      ),
                    ],
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add To Cart  ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: blFa),
                          ),
                          Icon(
                            IconsaxPlusLinear.shopping_cart,
                            color: blFa,
                            size: 24,
                          ),
                        ],
                      ),
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
