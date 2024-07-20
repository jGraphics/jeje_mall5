import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeje_mall5/constants/colors.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Order History',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         // Add your order history list here
            Expanded(
              child: ListView(
                children: const [
                  // Example order item
                  ListTile(
                    title: Text('Order #12345'),
                    subtitle: Text('Placed on 2024-07-15'),
                  ),
                  // More order items...
                ],
              ),
            ),
            const SizedBox(height: 20),
       
          
          ],
        ),
      ),
    );
  }
}