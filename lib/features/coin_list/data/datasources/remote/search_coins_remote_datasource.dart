import 'package:brasilcard/core/error/exception.dart';
import 'package:brasilcard/core/network/http_client.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';

abstract class ISearchCoinsRemoteDatasource {
  Future<List<CoinModel>> getCoinList({String? query});
}

class SearchCoinsRemoteDatasource implements ISearchCoinsRemoteDatasource {
  SearchCoinsRemoteDatasource(this._client);

  final IHttpClientService _client;

  @override
  Future<List<CoinModel>> getCoinList({String? query}) async {
    try {
      final endpoint =
          query != null && query.isNotEmpty
              ? '/assets?search=$query'
              : '/assets';
      final response = await _client.get(endpoint);
      final json = response['data'] as List<dynamic>;
      return json.map((e) => CoinModel.fromMap(e)).toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }
}
