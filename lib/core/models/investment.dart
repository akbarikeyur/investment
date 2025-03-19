class Investment {
  final String id;
  final String name;
  final double amount;

  Investment({required this.id, required this.name, required this.amount});

  factory Investment.fromJson(Map<String, dynamic> json) {
    return Investment(
      id: json['id'],
      name: json['name'],
      amount: json['amount'].toDouble(),
    );
  }
}
