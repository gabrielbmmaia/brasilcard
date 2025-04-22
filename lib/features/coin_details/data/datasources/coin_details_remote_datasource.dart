import 'package:brasilcard/core/error/exception.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';

import '../../../../../core/services/http_service.dart';

abstract class ICoinDetailsRemoteDatasource {
  Future<CoinModel> getCoinDetails({required String coinId});
}

class CoinDetailsRemoteDatasource implements ICoinDetailsRemoteDatasource {
  const CoinDetailsRemoteDatasource(this._client);

  final IHttpClientService _client;

  @override
  Future<CoinModel> getCoinDetails({required String coinId}) async {
    try {
      final endpoint = '/assets/$coinId';
      final response = await _client.get(endpoint);
      final json = response['data'];
      return CoinModel.fromMap(json);
    } on ServerException {
      rethrow;
    } on NoInternetException {
      rethrow;
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }
}
