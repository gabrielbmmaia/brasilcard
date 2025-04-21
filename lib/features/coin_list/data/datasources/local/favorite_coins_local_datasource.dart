import 'package:brasilcard/core/services/hive_keys.dart';

import '../../../../../core/services/hive_service.dart';

abstract class IFavoriteCoinsLocalDatasource {
  Future<void> saveFavoriteCoins(String coinId);

  Future<List<String>> getFavoriteCoinsId();

  Future<void> deleteFavoriteCoin(String coinId);
}

class FavoriteCoinsLocalDatasource implements IFavoriteCoinsLocalDatasource {
  const FavoriteCoinsLocalDatasource(this._hiveService);

  final HiveService _hiveService;

  @override
  Future<void> saveFavoriteCoins(String coinId) async {
    await _hiveService.add<String>(
      boxName: HiveKeys.favoriteCoins,
      value: coinId,
    );
  }

  @override
  Future<List<String>> getFavoriteCoinsId() async {
    return await _hiveService.getAll<String>(boxName: HiveKeys.favoriteCoins);
  }

  @override
  Future<void> deleteFavoriteCoin(String coinId) async {
    await _hiveService.delete(boxName: HiveKeys.favoriteCoins, key: coinId);
  }
}
