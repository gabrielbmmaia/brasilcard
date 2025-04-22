import 'package:brasilcard/core/services/hive_keys.dart';
import 'package:hive/hive.dart';

abstract class IFavoriteCoinsLocalDatasource {
  Future<void> saveFavoriteCoin({required String coinId});

  List<String> getFavoriteCoinsId();

  Future<void> deleteFavoriteCoin({required String coinId});

  Future<void> clearFavoriteCoins();
}

class FavoriteCoinsLocalDatasource implements IFavoriteCoinsLocalDatasource {
  final box = Hive.box<String>(HiveKeys.favoriteCoins);

  static Future<void> init() async {
    await Hive.openBox<String>(HiveKeys.favoriteCoins);
  }

  @override
  Future<void> saveFavoriteCoin({required String coinId}) async {
    if (!box.containsKey(coinId)) {
      await box.put(coinId, coinId);
    }
  }

  @override
  List<String> getFavoriteCoinsId() => box.values.toList();

  @override
  Future<void> deleteFavoriteCoin({required String coinId}) async {
    await box.delete(coinId);
  }

  @override
  Future<void> clearFavoriteCoins() async => await box.clear();
}
