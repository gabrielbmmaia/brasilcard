import 'package:brasilcard/core/error/exception.dart';
import 'package:brasilcard/core/services/http_service.dart';
import 'package:brasilcard/features/coin_list/data/datasources/remote/search_coins_remote_datasource.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClientService extends Mock implements IHttpClientService {}

void main() {
  late ISearchCoinsRemoteDatasource datasource;
  late MockHttpClientService mockHttp;

  setUp(() {
    mockHttp = MockHttpClientService();
    datasource = SearchCoinsRemoteDatasource(mockHttp);
  });

  final fakeResponse = {
    'data': [
      {
        'id': 'bitcoin',
        'rank': '1',
        'symbol': 'BTC',
        'name': 'Bitcoin',
        'supply': '18600000',
        'maxSupply': '21000000',
        'marketCapUsd': '860000000000',
        'volumeUsd24Hr': '32000000000',
        'priceUsd': '46000',
        'changePercent24Hr': '2.34',
        'vwap24Hr': '45500',
      },
    ],
  };

  group('getCoinList', () {
    test(
      'should return list of CoinModel when response is successful with query',
          () async {
        const query = 'bit';
        // Mocking the correct endpoint with query parameter
        when(
              () => mockHttp.get('/assets?limit=100&offset=0&search=$query'),
        ).thenAnswer((_) async => fakeResponse);

        final result = await datasource.getCoinList(query: query);

        expect(result, isA<List<CoinModel>>());
        expect(result.first.name, 'Bitcoin');
        verify(() => mockHttp.get('/assets?limit=100&offset=0&search=$query'))
            .called(1);
      },
    );

    test(
      'should return list of CoinModel when response is successful without query',
          () async {
        // Mocking the correct endpoint without query parameter
        when(
              () => mockHttp.get('/assets?limit=100&offset=0'),
        ).thenAnswer((_) async => fakeResponse);

        final result = await datasource.getCoinList();

        expect(result, isA<List<CoinModel>>());
        verify(() => mockHttp.get('/assets?limit=100&offset=0')).called(1);
      },
    );

    test('should throw ServerException when server returns error', () async {
      when(
            () => mockHttp.get(any()),
      ).thenThrow(ServerException(message: '', statusCode: 500));

      expect(
            () => datasource.getCoinList(query: 'btc'),
        throwsA(isA<ServerException>()),
      );
      verify(() => mockHttp.get('/assets?limit=100&offset=0&search=btc'))
          .called(1);
    });

    test('should throw NoInternetException when no internet', () async {
      when(
            () => mockHttp.get(any()),
      ).thenThrow(NoInternetException(message: ''));

      expect(
            () => datasource.getCoinList(),
        throwsA(isA<NoInternetException>()),
      );
      verify(() => mockHttp.get('/assets?limit=100&offset=0')).called(1);
    });

    test('should throw UnknownException for unknown errors', () async {
      when(
            () => mockHttp.get(any()),
      ).thenThrow(Exception('Something went wrong'));

      expect(() => datasource.getCoinList(), throwsA(isA<UnknownException>()));
      verify(() => mockHttp.get('/assets?limit=100&offset=0')).called(1);
    });
  });

  group('getCoinListFromIds', () {
    test(
      'should return list of CoinModel when response is successful',
          () async {
        const ids = ['bitcoin', 'ethereum'];
        final endpoint = '/assets?ids=bitcoin,ethereum';

        when(
              () => mockHttp.get(endpoint),
        ).thenAnswer((_) async => fakeResponse);

        final result = await datasource.getCoinListFromIds(coinIds: ids);

        expect(result, isA<List<CoinModel>>());
        verify(() => mockHttp.get(endpoint)).called(1);
      },
    );

    test('should throw ServerException', () async {
      const ids = ['bitcoin'];
      final endpoint = '/assets?ids=bitcoin';

      when(
            () => mockHttp.get(endpoint),
      ).thenThrow(ServerException(message: '', statusCode: 500));

      expect(
            () => datasource.getCoinListFromIds(coinIds: ids),
        throwsA(isA<ServerException>()),
      );
      verify(() => mockHttp.get(endpoint)).called(1);
    });

    test('should throw NoInternetException', () async {
      const ids = ['bitcoin'];
      final endpoint = '/assets?ids=bitcoin';

      when(
            () => mockHttp.get(endpoint),
      ).thenThrow(NoInternetException(message: ''));

      expect(
            () => datasource.getCoinListFromIds(coinIds: ids),
        throwsA(isA<NoInternetException>()),
      );
      verify(() => mockHttp.get(endpoint)).called(1);
    });

    test('should throw UnknownException', () async {
      const ids = ['bitcoin'];
      final endpoint = '/assets?ids=bitcoin';

      when(
            () => mockHttp.get(endpoint),
      ).thenThrow(Exception('Erro desconhecido'));

      expect(
            () => datasource.getCoinListFromIds(coinIds: ids),
        throwsA(isA<UnknownException>()),
      );
      verify(() => mockHttp.get(endpoint)).called(1);
    });
  });
}
