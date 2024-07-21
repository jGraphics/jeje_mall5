import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:jeje_mall5/model/order_model.dart';
import 'package:jeje_mall5/constants/order_local.dart';

class OrderHistoryPage extends StatefulWidget {
  // Removed `const` keyword here
  OrderHistoryPage({super.key, required List orderHistory});

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  late Future<List<Order>> _orderHistoryFuture;

  @override
  void initState() {
    super.initState();
    _orderHistoryFuture = fetchOrdersFromLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Order>>(
        future: _orderHistoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Center(
                  child: Lottie.network(
                    'https://lottie.host/945b8558-0f5c-4792-a793-d5f13dc11611/hCCFhsPEoC.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const Text(
                  'No Orders Yet',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                  ),
                ),
              ],
            );
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Order ${index + 1}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amount: ₦${order.amount.toStringAsFixed(2)}'),
                        Text('Date: ${formatter.format(order.date)}'),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
