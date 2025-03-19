class Investment {
  final String id;
  final String name;
  final String description;
  final int amount;
  final double roi;
  final String riskLevel;
  final String duration;
  final String longDescription;

  Investment({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.roi,
    required this.riskLevel,
    required this.duration,
    required this.longDescription,
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
      longDescription: json["longDescription"],
    );
  }
}
