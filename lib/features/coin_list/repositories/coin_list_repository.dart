import 'package:brasilcard/core/error/base_error.dart';
import 'package:brasilcard/core/utils/result_wrapper.dart';
import 'package:brasilcard/core/utils/type_def.dart';
import 'package:brasilcard/features/coin_list/data/datasources/remote/search_coins_remote_datasource.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';

abstract class ICoinListRepository {
  ResultFuture<List<CoinModel>> getCoinList({String? query});
}

class CoinListRepository implements ICoinListRepository {
  const CoinListRepository(this.remote);

  final ISearchCoinsRemoteDatasource remote;

  @override
  ResultFuture<List<CoinModel>> getCoinList({String? query}) async {
    try {
      final result = await remote.getCoinList(query: query);
      return ResultSuccess(result);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
