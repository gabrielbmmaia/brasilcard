import 'package:brasilcard/core/error/exception.dart';
import 'package:brasilcard/features/coin_details/data/models/graph_model.dart';

import '../../../../../core/services/http_service.dart';
import '../models/graph_epoch.dart';

abstract class ICoinHistoryRemoteDatasource {
  Future<List<GraphModel>> getCoinHistory({
    required String coinId,
    required GraphEpoch epoch,
  });
}

class CoinHistoryRemoteDatasource implements ICoinHistoryRemoteDatasource {
  const CoinHistoryRemoteDatasource(this._client);

  final IHttpClientService _client;

  @override
  Future<List<GraphModel>> getCoinHistory({
    required String coinId,
    required GraphEpoch epoch,
  }) async {
    try {
      final endpoint =
          '/assets'
          '/$coinId'
          '/history'
          '?interval=${epoch.interval}'
          '&start=${epoch.start}'
          '&end=${epoch.now}';
      final response = await _client.get(endpoint);
      final json = response['data'] as List<dynamic>;
      return json.map((e) => GraphModel.fromMap(e)).toList();
    } on ServerException {
      rethrow;
    } on NoInternetException {
      rethrow;
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }
}
