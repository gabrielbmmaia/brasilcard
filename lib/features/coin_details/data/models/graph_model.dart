class GraphModel {
  GraphModel({required this.priceUsd, required this.time, required this.date});

  final double priceUsd;
  final int time;
  final String date;

  Map<String, dynamic> toMap() {
    return {'priceUsd': priceUsd, 'time': time, 'date': date};
  }

  factory GraphModel.fromMap(Map<String, dynamic> map) {
    return GraphModel(
      priceUsd: double.tryParse(map['priceUsd'] ?? '0') ?? 0.0,
      time: map['time'] as int,
      date: map['date'] as String,
    );
  }
}
