import 'package:equatable/equatable.dart';

class CoinModel extends Equatable {
  const CoinModel({
    required this.id,
    required this.rank,
    required this.symbol,
    required this.name,
    required this.supply,
    required this.maxSupply,
    required this.marketCapUsd,
    required this.volumeUsd24Hr,
    required this.priceUsd,
    required this.changePercent24Hr,
    required this.vwap24Hr,
    required this.explorer,
  });

  final String id;
  final String rank;
  final String symbol;
  final String name;
  final double supply;
  final double? maxSupply;
  final double marketCapUsd;
  final double volumeUsd24Hr;
  final double priceUsd;
  final double changePercent24Hr;
  final double vwap24Hr;
  final String explorer;

  @override
  List<Object?> get props => throw UnimplementedError();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rank': rank,
      'symbol': symbol,
      'name': name,
      'supply': supply,
      'maxSupply': maxSupply,
      'marketCapUsd': marketCapUsd,
      'volumeUsd24Hr': volumeUsd24Hr,
      'priceUsd': priceUsd,
      'changePercent24Hr': changePercent24Hr,
      'vwap24Hr': vwap24Hr,
      'explorer': explorer,
    };
  }

  factory CoinModel.fromMap(Map<String, dynamic> map) {
    return CoinModel(
      id: map['id'] ?? '',
      rank: map['rank'] ?? '',
      symbol: map['symbol'] ?? '',
      name: map['name'] ?? '',
      supply: double.tryParse(map['supply'] ?? '0') ?? 0.0,
      maxSupply: double.tryParse(map['maxSupply'] ?? '0'),
      marketCapUsd: double.tryParse(map['marketCapUsd'] ?? '0') ?? 0.0,
      volumeUsd24Hr: double.tryParse(map['volumeUsd24Hr'] ?? '0') ?? 0.0,
      priceUsd: double.tryParse(map['priceUsd'] ?? '0') ?? 0.0,
      changePercent24Hr:
          double.tryParse(map['changePercent24Hr'] ?? '0') ?? 0.0,
      vwap24Hr: double.tryParse(map['vwap24Hr'] ?? '0') ?? 0.0,
      explorer: map['explorer'] ?? '',
    );
  }
}
