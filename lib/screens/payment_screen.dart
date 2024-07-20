import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeje_mall5/constants/colors.dart';
import 'package:jeje_mall5/screens/payment_success.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _cardNumberController = TextEditingController(text: '1234 5678 9012 3456');
  final TextEditingController _expiryDateController = TextEditingController(text: '12/24');
  final TextEditingController _cvvController = TextEditingController(text: '123');

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: colorBgW,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                './assets/images/Card.png',
                height: 217,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _expiryDateController,
                      decoration: const InputDecoration(
                        labelText: 'Expiry Date (MM/YY)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _cvvController,
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 62),
              Container(
                width: 307,
                height: 44,
                decoration: const BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: TextButton(
               
                  onPressed: () {
                  final uniqueTransRef = PayWithPayStack().generateUuidV4();

                  PayWithPayStack().now(
                      context: context,
                      secretKey:
                          "sk_test_868da27a1a775e6d8adf0d2be76ab667bb2abbc5",
                      customerEmail: "jejelovegraphics@gmail.com",
                      reference: uniqueTransRef,
                      currency: "NGN",
                      amount: 208700.66, 
                      transactionCompleted: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CheckoutSuccessPage(),
                          ),
                        );
                      },
                      transactionNotCompleted: () {
                        if (kDebugMode) {
                          print("Transaction Not Successful!");
                        }
                      },
                      callbackUrl: 'product-screen');
                },
                  child: Text(
                    'Make Payment',
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
            ],
          ),
        ),
      ),
    );
  }
}

