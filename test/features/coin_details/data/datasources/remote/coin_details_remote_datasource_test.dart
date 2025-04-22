import 'package:brasilcard/core/error/exception.dart';
import 'package:brasilcard/core/services/http_service.dart';
import 'package:brasilcard/features/coin_details/data/datasources/coin_details_remote_datasource.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClientService extends Mock implements IHttpClientService {}

void main() {
  late CoinDetailsRemoteDatasource datasource;
  late MockHttpClientService mockHttp;

  const coinId = 'bitcoin';

  setUp(() {
    mockHttp = MockHttpClientService();
    datasource = CoinDetailsRemoteDatasource(mockHttp);
  });

  final fakeResponse = {
    'data': {
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
  };

  test('should return CoinModel when the response is successful', () async {
    when(
      () => mockHttp.get('/assets/$coinId'),
    ).thenAnswer((_) async => fakeResponse);

    final result = await datasource.getCoinDetails(coinId: coinId);

    expect(result, isA<CoinModel>());
    expect(result.name, 'Bitcoin');
    verify(() => mockHttp.get('/assets/$coinId')).called(1);
  });

  test(
    'should throw ServerException when the server returns an error',
    () async {
      when(
        () => mockHttp.get(any()),
      ).thenThrow(ServerException(message: '', statusCode: 999));

      expect(
        () => datasource.getCoinDetails(coinId: coinId),
        throwsA(isA<ServerException>()),
      );
      verify(() => mockHttp.get('/assets/$coinId')).called(1);
    },
  );

  test(
    'should throw NoInternetException when there is no internet connection',
    () async {
      when(
        () => mockHttp.get(any()),
      ).thenThrow(NoInternetException(message: ''));

      expect(
        () => datasource.getCoinDetails(coinId: coinId),
        throwsA(isA<NoInternetException>()),
      );
      verify(() => mockHttp.get('/assets/$coinId')).called(1);
    },
  );

  test('should throw UnknownException when an unknown error occurs', () async {
    when(() => mockHttp.get(any())).thenThrow(Exception('Algum erro'));

    expect(
      () => datasource.getCoinDetails(coinId: coinId),
      throwsA(isA<UnknownException>()),
    );
    verify(() => mockHttp.get('/assets/$coinId')).called(1);
  });
}
