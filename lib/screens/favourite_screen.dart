import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';

class TestPaymentScreen extends StatefulWidget {
  const TestPaymentScreen({super.key});

  @override
  State<TestPaymentScreen> createState() => _TestPaymentState();
}

class _TestPaymentState extends State<TestPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PAYMENT Now SCREEN'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  final uniqueTransRef = PayWithPayStack().generateUuidV4();

                  PayWithPayStack().now(
                      context: context,
                      secretKey:
                          "sk_test_868da27a1a775e6d8adf0d2be76ab667bb2abbc5",
                      customerEmail: "jejelovegraphics@gmail.com",
                      reference: uniqueTransRef,
                      currency: "NGN",
                      amount: 200.66, // Convert to double
                      transactionCompleted: () {
                        if (kDebugMode) {
                          print("Transaction Successful");
                        }
                      },
                      transactionNotCompleted: () {
                        if (kDebugMode) {
                          print("Transaction Not Successful!");
                        }
                      },
                      callbackUrl: 'product-screen');
                },
                child: const Text(
                  "Pay With PayStack",
                  style: TextStyle(fontSize: 23),
                ))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
