import 'package:brasilcard/core/error/base_error.dart';
import 'package:brasilcard/core/utils/result_wrapper.dart';
import 'package:brasilcard/core/utils/type_def.dart';
import 'package:brasilcard/features/coin_details/data/datasources/coin_history_remote_datasource.dart';
import 'package:brasilcard/features/coin_details/data/models/graph_model.dart';

import '../models/graph_epoch.dart';

abstract class ICoinHistoryRepository {
  ResultFuture<List<GraphModel>> getCoinHistory({
    required String coinId,
    required GraphEpoch epoch,
  });
}

class CoinHistoryRepository implements ICoinHistoryRepository {
  const CoinHistoryRepository(this.remote);

  final ICoinHistoryRemoteDatasource remote;

  @override
  ResultFuture<List<GraphModel>> getCoinHistory({
    required String coinId,
    required GraphEpoch epoch,
  }) async {
    try {
      final result = await remote.getCoinHistory(coinId: coinId, epoch: epoch);
      return ResultSuccess(result);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
