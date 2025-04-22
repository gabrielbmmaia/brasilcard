import 'package:brasilcard/core/services/hive_keys.dart';
import 'package:hive/hive.dart';

abstract class IFavoriteCoinsLocalDatasource {
  Future<void> saveFavoriteCoin({required String coinId});

  List<String> getFavoriteCoinsId();

  Future<void> deleteFavoriteCoin({required String coinId});

  Future<void> clearFavoriteCoins();
}

class FavoriteCoinsLocalDatasource implements IFavoriteCoinsLocalDatasource {
  FavoriteCoinsLocalDatasource([Box<String>? box])
    : _box = box ?? Hive.box<String>(HiveKeys.favoriteCoins);

  final Box<String> _box;

  static Future<void> init() async {
    await Hive.openBox<String>(HiveKeys.favoriteCoins);
  }

  @override
  Future<void> saveFavoriteCoin({required String coinId}) async {
    if (!_box.containsKey(coinId)) {
      await _box.put(coinId, coinId);
    }
  }

  @override
  List<String> getFavoriteCoinsId() => _box.values.toList();

  @override
  Future<void> deleteFavoriteCoin({required String coinId}) async {
    await _box.delete(coinId);
  }

  @override
  Future<void> clearFavoriteCoins() async => await _box.clear();
}
