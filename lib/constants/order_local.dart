import 'dart:convert';
import 'package:jeje_mall5/model/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveOrdersLocally(List<Order> orders) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> ordersJson = orders.map((order) => json.encode(order.toJson())).toList();
  await prefs.setStringList('orders', ordersJson);
}

Future<void> saveOrdersToLocalStorage(List<Order> orders) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> ordersJson = orders.map((order) => json.encode(order.toJson())).toList();
  await prefs.setStringList('orderHistory', ordersJson);
}

Future<List<Order>> fetchOrdersFromLocalStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String>? ordersJson = prefs.getStringList('orderHistory');
  if (ordersJson == null) {
    return [];
  }
  return ordersJson.map((json) => Order.fromJson(jsonDecode(json))).toList();
}