import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeje_mall5/constants/colors.dart';
import 'package:jeje_mall5/model/order_model.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late Future<List<Order>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = fetchOrderHistory();
  }

  Future<List<Order>> fetchOrderHistory() async {
    // Replace this with your API call or local storage fetch logic
    // Here is a sample list of orders for demonstration
    await Future.delayed(const Duration(seconds: 2)); // Simulating network delay
    return [
      Order(id: '12345', date: '2024-07-15', totalAmount: 1500.00),
      Order(id: '12346', date: '2024-07-16', totalAmount: 2500.00),
      Order(id: '12347', date: '2024-07-17', totalAmount: 3500.00),
    ];
  }

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
            Expanded(
              child: FutureBuilder<List<Order>>(
                future: futureOrders,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No orders found.'));
                  } else {
                    List<Order> orders = snapshot.data!;
                    return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        Order order = orders[index];
                        return ListTile(
                          title: Text('Order #${order.id}'),
                          subtitle: Text('Placed on ${order.date}'),
                          trailing: Text('₦${order.totalAmount.toStringAsFixed(2)}'),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
