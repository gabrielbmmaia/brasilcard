import 'package:brasilcard/core/error/exception.dart';
import 'package:brasilcard/core/services/http_service.dart';
import 'package:brasilcard/features/coin_details/data/datasources/coin_history_remote_datasource.dart';
import 'package:brasilcard/features/coin_details/data/models/graph_epoch.dart';
import 'package:brasilcard/features/coin_details/data/models/graph_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClientService extends Mock implements IHttpClientService {}

void main() {
  late CoinHistoryRemoteDatasource datasource;
  late MockHttpClientService mockHttp;

  const coinId = 'bitcoin';
  final epoch = GraphEpoch(interval: 'm5', now: 10000, start: 1000000);

  setUp(() {
    mockHttp = MockHttpClientService();
    datasource = CoinHistoryRemoteDatasource(mockHttp);
  });

  final fakeResponse = {
    'data': [
      {'priceUsd': '46000', 'time': 1620000000000, 'date': '1620000000000'},
      {'priceUsd': '46500', 'time': 1620003600000, 'date': '1620003600000'},
    ],
  };

  test(
    'should return List<GraphModel> when the response is successful',
    () async {
      final endpoint =
          '/assets'
          '/$coinId'
          '/history'
          '?interval=${epoch.interval}'
          '&start=${epoch.start}'
          '&end=${epoch.now}';

      when(() => mockHttp.get(endpoint)).thenAnswer((_) async => fakeResponse);

      final result = await datasource.getCoinHistory(
        coinId: coinId,
        epoch: epoch,
      );

      expect(result, isA<List<GraphModel>>());
      expect(result.length, 2);
      verify(() => mockHttp.get(endpoint)).called(1);
    },
  );

  test('should throw ServerException when server returns error', () async {
    final endpoint =
        '/assets'
        '/$coinId'
        '/history'
        '?interval=${epoch.interval}'
        '&start=${epoch.start}'
        '&end=${epoch.now}';

    when(
      () => mockHttp.get(any()),
    ).thenThrow(ServerException(message: '', statusCode: 500));

    expect(
      () => datasource.getCoinHistory(coinId: coinId, epoch: epoch),
      throwsA(isA<ServerException>()),
    );
    verify(() => mockHttp.get(endpoint)).called(1);
  });

  test('should throw NoInternetException when there is no internet', () async {
    final endpoint =
        '/assets'
        '/$coinId'
        '/history'
        '?interval=${epoch.interval}'
        '&start=${epoch.start}'
        '&end=${epoch.now}';

    when(() => mockHttp.get(any())).thenThrow(NoInternetException(message: ''));

    expect(
      () => datasource.getCoinHistory(coinId: coinId, epoch: epoch),
      throwsA(isA<NoInternetException>()),
    );
    verify(() => mockHttp.get(endpoint)).called(1);
  });

  test('should throw UnknownException when an unknown error occurs', () async {
    final endpoint =
        '/assets'
        '/$coinId'
        '/history'
        '?interval=${epoch.interval}'
        '&start=${epoch.start}'
        '&end=${epoch.now}';

    when(() => mockHttp.get(any())).thenThrow(Exception('Some error'));

    expect(
      () => datasource.getCoinHistory(coinId: coinId, epoch: epoch),
      throwsA(isA<UnknownException>()),
    );
    verify(() => mockHttp.get(endpoint)).called(1);
  });
}
