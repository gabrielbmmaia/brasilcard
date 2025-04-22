import 'package:brasilcard/core/error/exception.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';

import '../../../../../core/services/http_service.dart';

abstract class ISearchCoinsRemoteDatasource {
  Future<List<CoinModel>> getCoinList({
    String? query,
    int? limit = 100,
    int? offset = 0,
  });

  Future<List<CoinModel>> getCoinListFromIds({required List<String> coinIds});
}

class SearchCoinsRemoteDatasource implements ISearchCoinsRemoteDatasource {
  const SearchCoinsRemoteDatasource(this._client);

  final IHttpClientService _client;

  @override
  Future<List<CoinModel>> getCoinList({
    String? query,
    int? limit = 100,
    int? offset = 0,
  }) async {
    try {
      String endpoint = '/assets?limit=$limit&offset=$offset';
      if (query != null) {
        endpoint += '&search=$query';
      }
      final response = await _client.get(endpoint);
      final json = response['data'] as List<dynamic>;
      return json.map((e) => CoinModel.fromMap(e)).toList();
    } on ServerException {
      rethrow;
    } on NoInternetException {
      rethrow;
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<List<CoinModel>> getCoinListFromIds({
    required List<String> coinIds,
  }) async {
    try {
      final coins = coinIds.join(',');
      final response = await _client.get('/assets?ids=$coins');
      final json = response['data'] as List<dynamic>;
      return json.map((e) => CoinModel.fromMap(e)).toList();
    } on ServerException {
      rethrow;
    } on NoInternetException {
      rethrow;
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }
}
