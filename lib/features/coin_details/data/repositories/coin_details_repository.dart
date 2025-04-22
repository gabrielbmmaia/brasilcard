import 'package:brasilcard/core/error/base_error.dart';
import 'package:brasilcard/core/utils/result_wrapper.dart';
import 'package:brasilcard/core/utils/type_def.dart';
import 'package:brasilcard/features/coin_details/data/datasources/coin_details_remote_datasource.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';

abstract class ICoinDetailsRepository {
  ResultFuture<CoinModel> getCoinDetails({required String coinId});
}

class CoinDetailsRepository implements ICoinDetailsRepository {
  const CoinDetailsRepository(this.remote);

  final ICoinDetailsRemoteDatasource remote;

  @override
  ResultFuture<CoinModel> getCoinDetails({required String coinId}) async {
    try {
      final result = await remote.getCoinDetails(coinId: coinId);
      return ResultSuccess(result);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
