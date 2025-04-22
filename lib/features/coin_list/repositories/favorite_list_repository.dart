import 'package:brasilcard/core/error/base_error.dart';
import 'package:brasilcard/core/utils/result_wrapper.dart';
import 'package:brasilcard/core/utils/type_def.dart';
import 'package:brasilcard/features/coin_list/data/datasources/local/favorite_coins_local_datasource.dart';

abstract class IFavoriteListRepository {
  ResultFuture<void> saveFavoriteCoins({required String coinId});

  ResultFuture<List<String>> getFavoriteCoinsId();

  ResultFuture<void> deleteFavoriteCoin({required String coinId});

  ResultFuture<void> clearFavoriteCoins();
}

class FavoriteListRepository implements IFavoriteListRepository {
  const FavoriteListRepository(this.local);

  final IFavoriteCoinsLocalDatasource local;

  @override
  ResultFuture<void> deleteFavoriteCoin({required String coinId}) async {
    try {
      await local.deleteFavoriteCoin(coinId: coinId);
      return ResultSuccessNullable();
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }

  @override
  ResultFuture<List<String>> getFavoriteCoinsId() async {
    try {
      final result = local.getFavoriteCoinsId();
      return ResultSuccess(result);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }

  @override
  ResultFuture<void> saveFavoriteCoins({required String coinId}) async {
    try {
      await local.saveFavoriteCoin(coinId: coinId);
      return ResultSuccessNullable();
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }

  @override
  ResultFuture<void> clearFavoriteCoins() async {
    try {
      await local.clearFavoriteCoins();
      return ResultSuccessNullable();
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
