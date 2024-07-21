class Order {
  final String id;
  final DateTime date;
  final double amount;

  Order({
    required this.id,
    required this.date,
    required this.amount,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      date: DateTime.parse(json['date']),
      amount: json['amount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'amount': amount,
    };
  }
}
