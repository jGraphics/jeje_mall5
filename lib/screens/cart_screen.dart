import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:jeje_mall5/constants/colors.dart';
import 'package:jeje_mall5/model/message_res.dart';
import 'package:jeje_mall5/screens/checkout_screen2.dart';
import 'package:jeje_mall5/apis/models/listOfProductItem.dart';

class CartPage extends StatefulWidget {
  final List<Item> cart;
  final void Function(Item product) removeFromCart;
  final void Function() updateCart;

  const CartPage({
    super.key,
    required this.cart,
    required this.removeFromCart,
    required this.updateCart,
  });

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final NumberFormat currencyFormat =
      NumberFormat.currency(symbol: '₦', decimalDigits: 2);
  final TextEditingController _discountCodeController = TextEditingController();

  void checkout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CheckoutStage2()),
    );
    setState(() {
      widget.cart.clear();
    });

    widget.updateCart(); // Update cart state
    success(context: context, message: 'Cart cleared.');
  }

  void incrementQuantity(Item product) {
    setState(() {
      product.quantity++;
    });
    widget.updateCart(); // Update cart state
  }

  void decrementQuantity(Item product) {
    setState(() {
      if (product.quantity > 1) {
        product.quantity--;
      } else {
        success(context: context, message: '${product.name} removed from cart');
        widget.removeFromCart(product);
      }
    });
    widget.updateCart(); // Update cart state
  }

  @override
  Widget build(BuildContext context) {
    const double deliveryFee = 1500.00;
    double subTotalPrice = widget.cart.fold(0.00, (previousValue, product) {
      return previousValue +
          ((product.currentPrice?[0].ngn[0] ?? 0.0) * product.quantity);
    });
    double totalPrice = subTotalPrice + deliveryFee;

    return Scaffold(
      appBar: AppBar(
         leadingWidth: 120,
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
          'Cart',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
              height: 1.22,
              color: blFa,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: colorBgW,
      body: SingleChildScrollView(
        child: widget.cart.isNotEmpty
            ? Column(
                children: [
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.cart.length +
                        1, // +1 for the shopping summary card
                    physics: const NeverScrollableScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemBuilder: (context, index) {
                      if (index < widget.cart.length) {
                        Item product = widget.cart[index];
                        return Card(
                          color: colorBgW,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: const BorderSide(color: ct, width: 1.0),
                          ),
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            leading: Image.network(
                              'https://api.timbu.cloud/images/${product.photos[0].url}',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              '${product.name}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '₦${currencyFormat.format(product.currentPrice?[0].ngn[0] ?? 0.0)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Quantity: ${product.quantity}'),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                              IconsaxPlusLinear.minus_square),
                                          onPressed: () {
                                            decrementQuantity(product);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                              IconsaxPlusLinear.add_square),
                                          onPressed: () {
                                            incrementQuantity(product);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(IconsaxPlusLinear.trash, color: Colors.red,),
                              onPressed: () {
                                success(
                                  context: context,
                                  message: '${product.name} removed from cart',
                                );
                                setState(() {
                                  widget.removeFromCart(product);
                                });
                                widget.updateCart(); // Update cart state
                              },
                            ),
                          ),
                        );
                      } else {
                        // This section creates the shopping summary card
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: const BorderSide(color: bgc, width: 1.0),
                          ),
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Shopping Summary',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: SizedBox(
                                        height: 41.18,
                                        width: 247,
                                        child: TextField(
                                          controller: _discountCodeController,
                                          decoration: const InputDecoration(
                                            labelText: 'Discount Code',
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(9))),
                                          ),
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 36,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _discountCodeController;
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: colorPrimary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                        ),
                                        child: const Text(
                                          'Apply',
                                          style: TextStyle(
                                              color: blFa, fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Sub-Total'),
                                    Text(
                                      currencyFormat.format(subTotalPrice),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Delivery Fee'),
                                    Text('₦1,500'),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total Amount:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      currencyFormat.format(totalPrice),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 35),
                                Center(
                                  child: Container(
                                    width: 307,
                                    height: 44,
                                    decoration: const BoxDecoration(
                                      color: colorPrimary,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const CheckoutStage2(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Checkout',
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: blFa,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 305),
                  Center(
                    child: Text(
                      'No Items in Cart',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
