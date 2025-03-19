class Investment {
  final String id;
  final String name;
  final String description;
  final int amount;
  final double roi;
  final String riskLevel;
  final String duration;

  Investment({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.roi,
    required this.riskLevel,
    required this.duration,
  });

  factory Investment.fromJson(Map<String, dynamic> json) {
    return Investment(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      amount: json["amount"],
      roi: json["roi"].toDouble(),
      riskLevel: json["riskLevel"],
      duration: json["duration"],
    );
  }
}
