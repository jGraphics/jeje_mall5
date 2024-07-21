import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:jeje_mall5/apis/timbu_api.dart';
import 'package:jeje_mall5/constants/colors.dart';
import 'package:jeje_mall5/screens/wish_list.dart';
import 'package:jeje_mall5/apis/connectionUrl/apiUrl.dart';
import 'package:jeje_mall5/constants/wish_list_provider.dart';
import 'package:jeje_mall5/apis/models/listOfProductItem.dart';

class ProductScreen extends StatefulWidget {
  final String category;
  final List<Item> cart;
  final void Function(Item product) addToCart;

  const ProductScreen(
      {super.key,
      required this.category,
      required this.cart,
      required this.addToCart});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final List<Item> _wishlistItems = [];
  late Future<void> futureProducts;
  final Map<String, List<Item>> _categoryProducts = {};
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  

  @override
  void initState() {
    super.initState();
  futureProducts = getAllProductByCategory();  }

Future<void> getAllProductByCategory() async {
    final get = Provider.of<TimbuApiProvider>(context, listen: false);

    try {
      // Fetch products for each category
      var techProducts = await get.fetchProductsByCategoryId(Timbu().techId);
      var menProducts = await get.fetchProductsByCategoryId(Timbu().menId);
      var womenProducts = await get.fetchProductsByCategoryId(Timbu().womenId);

      // Update state with fetched products
      setState(() {
        _categoryProducts['Tech-Gadget'] = techProducts;
        _categoryProducts['Men\'s-Fashion'] = menProducts;
        _categoryProducts['Women\'s-Fashion'] = womenProducts;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch products: $e');
      }
      //ui error msg here
    }
  }


// void getAllProductByCategory() async {
//   final timbu = Timbu(); // Assuming you have an instance of Timbu class
//   final categories = {
//     'Tech-Gadget': timbu.techId,
//     "Men's-Fashion": timbu.menId,
//     "Women's-Fashion": timbu.womenId,
//   };

//   for (var category in categories.keys) {
//     var products = await timbu.fetchProductsByCategoryId(categories[category]!);
//     setState(() {
//       _categoryProducts[category] = products;
//     });
//   }
// } 

  void addToWishlist(Item product) {
    final wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    if (!_wishlistItems.contains(product)) {
      wishlistProvider.addToWishlist(product);
      setState(() {
        _wishlistItems.add(product);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} added to wishlist'),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item is already in your wishlist'),
          duration: Duration(seconds: 2),
        ),
      );
    }
    const WishlistScreen(
      wishlistItems: [],
    ); // Add WishlistScreen to the options
  }

  void removeFromWishlist(Item product) {
    final wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    setState(() {
      _wishlistItems.remove(product);
    });
    wishlistProvider.removeFromWishlist(product);
  }

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    int wishlistItemCount = wishlistProvider.wishlistItems.length;
    final NumberFormat currencyFormat =
        NumberFormat.currency(symbol: '₦', decimalDigits: 2);

    return Scaffold(
        appBar: AppBar(
        leadingWidth: 99,
        backgroundColor: colorBgW,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: SizedBox(
            width: 200.0,
            child: Image.asset(
              'assets/images/mall_logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          'Product List',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
              color: blFa,
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(IconsaxPlusLinear.heart),
                color: blFa,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WishlistScreen(
                        wishlistItems: [],
                      ),
                    ),
                  );
                },
              ),
              if (wishlistItemCount > 0)
                Positioned(
                  right: 4,
                  top: 4,
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
                      '$wishlistItemCount',
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
        ],
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: colorBgW,
      body: _categoryProducts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: 380,
                    height: 232,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('./assets/images/hnc.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Premium Sound,',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Premium Savings',
                              style: TextStyle(
                                color: colorBgW,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Limited offer, hop on and get yours now',
                              style: TextStyle(
                                color: colorBgW,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 44),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _categoryProducts.keys.map((category) {
                      List<Item> products = _categoryProducts[category] ?? [];
                      return products.isEmpty
                      ? Center( child: Text('No PRODUCT AVAILABLE FOR $category'),)
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              category,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 360,
                            child: PageView.builder(
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentPageIndex = index;
                                });
                              },
                              itemCount: (products.length / 2).ceil(),
                              itemBuilder: (context, index) {
                                int start = index * 2;
                                int end =
                                    (index * 2 + 2).clamp(0, products.length);
                                List<Item> pageProducts =
                                    products.sublist(start, end);

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: pageProducts.map((product) {
                                    return Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         ViewProductPage(
                                            //       id: product.id,
                                            //       itemPrice: currencyFormat
                                            //           .format(product
                                            //                   .currentPrice?[0]
                                            //                   .ngn[0] ??
                                            //               0),
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                      ),
                                                      child: Image.network(
                                                        "https://api.timbu.cloud/images/${product.photos[0].url}",
                                                        height: 150,
                                                        width: double.infinity,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: _wishlistItems
                                                              .contains(product)
                                                          ? const Icon(
                                                              Icons.favorite,
                                                              color: Colors.red)
                                                          : const Icon(
                                                              Icons
                                                                  .favorite_border,
                                                              color:
                                                                  Colors.red),
                                                      onPressed: () {
                                                        if (_wishlistItems
                                                            .contains(
                                                                product)) {
                                                          removeFromWishlist(
                                                              product);
                                                        } else {
                                                          addToWishlist(
                                                              product);
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        product.name ?? '',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        product.description ??
                                                            '',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      const Row(
                                                        children: [
                                                          Image(
                                                              image: AssetImage(
                                                                  'assets/images/fill_star.png')),
                                                          Image(
                                                              image: AssetImage(
                                                                  'assets/images/fill_star.png')),
                                                          Image(
                                                              image: AssetImage(
                                                                  'assets/images/fill_star.png')),
                                                          Image(
                                                              image: AssetImage(
                                                                  'assets/images/fill_star.png')),
                                                          Image(
                                                              image: AssetImage(
                                                                  'assets/images/fill_star.png')),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        currencyFormat.format(
                                                            product
                                                                    .currentPrice?[
                                                                        0]
                                                                    .ngn[0] ??
                                                                0),
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      OutlinedButton(
                                                        onPressed: () {
                                                          widget.addToCart(
                                                              product);
                                                        },
                                                        style: ButtonStyle(
                                                          padding: WidgetStateProperty
                                                              .all(const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      20)),
                                                          side:
                                                              WidgetStateProperty
                                                                  .all(
                                                            const BorderSide(
                                                              color:
                                                                  colorPrimary,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          shape:
                                                              WidgetStateProperty
                                                                  .all(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14),
                                                            ),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'Add to Cart',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
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
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              (_categoryProducts[category]!.length / 2).ceil(),
                              (index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  width: 8.0,
                                  height: 8.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentPageIndex == index
                                        ? colorPrimary
                                        : Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
