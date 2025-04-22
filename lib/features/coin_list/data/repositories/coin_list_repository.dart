import 'package:brasilcard/core/error/base_error.dart';
import 'package:brasilcard/core/utils/result_wrapper.dart';
import 'package:brasilcard/core/utils/type_def.dart';
import 'package:brasilcard/features/coin_list/data/datasources/remote/search_coins_remote_datasource.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';

abstract class ICoinListRepository {
  ResultFuture<List<CoinModel>> getCoinList({
    String? query,
    int? limit = 100,
    int? offset = 0,
  });

  ResultFuture<List<CoinModel>> getCoinListFromIds({required List<String> ids});
}

class CoinListRepository implements ICoinListRepository {
  const CoinListRepository(this.remote);

  final ISearchCoinsRemoteDatasource remote;

  @override
  ResultFuture<List<CoinModel>> getCoinList({
    String? query,
    int? limit = 100,
    int? offset = 0,
  }) async {
    try {
      final result = await remote.getCoinList(
        query: query,
        offset: offset,
        limit: limit,
      );
      return ResultSuccess(result);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }

  @override
  ResultFuture<List<CoinModel>> getCoinListFromIds({
    required List<String> ids,
  }) async {
    try {
      if (ids.isEmpty) {
        return ResultSuccess([]);
      }
      final result = await remote.getCoinListFromIds(coinIds: ids);
      return ResultSuccess(result);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
