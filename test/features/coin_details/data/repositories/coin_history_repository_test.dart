import 'package:brasilcard/core/error/exception.dart';
import 'package:brasilcard/core/utils/result_wrapper.dart';
import 'package:brasilcard/features/coin_details/data/datasources/coin_history_remote_datasource.dart';
import 'package:brasilcard/features/coin_details/data/models/graph_epoch.dart';
import 'package:brasilcard/features/coin_details/data/models/graph_model.dart';
import 'package:brasilcard/features/coin_details/data/repositories/coin_history_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoinHistoryRemoteDatasource extends Mock
    implements ICoinHistoryRemoteDatasource {}

void main() {
  late ICoinHistoryRepository repository;
  late MockCoinHistoryRemoteDatasource mockDatasource;

  const coinId = 'bitcoin';
  const epoch = GraphEpoch(interval: '1d', start: 1634582400, now: 1634672400);

  setUp(() {
    mockDatasource = MockCoinHistoryRemoteDatasource();
    repository = CoinHistoryRepository(mockDatasource);
  });

  final mockGraphModels = [
    GraphModel(priceUsd: 45000.0, time: 1634582400, date: '2021-10-18'),
    GraphModel(priceUsd: 46000.0, time: 1634668800, date: '2021-10-19'),
  ];

  group('getCoinHistory', () {
    test(
      'should return a ResultSuccess with GraphModels when data is fetched successfully',
      () async {
        when(
          () => mockDatasource.getCoinHistory(coinId: coinId, epoch: epoch),
        ).thenAnswer((_) async => mockGraphModels);

        final result = await repository.getCoinHistory(
          coinId: coinId,
          epoch: epoch,
        );

        expect(result, isA<ResultSuccess<List<GraphModel>>>());
        expect(result.data, mockGraphModels);
        verify(
          () => mockDatasource.getCoinHistory(coinId: coinId, epoch: epoch),
        ).called(1);
      },
    );

    test(
      'should return ResultError when datasource throws ServerException',
      () async {
        final exception = ServerException(
          message: 'Server error',
          statusCode: 500,
        );
        when(
          () => mockDatasource.getCoinHistory(coinId: coinId, epoch: epoch),
        ).thenThrow(exception);

        final result = await repository.getCoinHistory(
          coinId: coinId,
          epoch: epoch,
        );

        expect(result, isA<ResultError>());
        expect(result.error?.message, exception.toString());
        verify(
          () => mockDatasource.getCoinHistory(coinId: coinId, epoch: epoch),
        ).called(1);
      },
    );

    test(
      'should return ResultError when datasource throws NoInternetException',
      () async {
        final exception = NoInternetException(message: 'No internet');
        when(
          () => mockDatasource.getCoinHistory(coinId: coinId, epoch: epoch),
        ).thenThrow(exception);

        final result = await repository.getCoinHistory(
          coinId: coinId,
          epoch: epoch,
        );

        expect(result, isA<ResultError>());
        expect(result.error?.message, exception.toString());
        verify(
          () => mockDatasource.getCoinHistory(coinId: coinId, epoch: epoch),
        ).called(1);
      },
    );

    test(
      'should return ResultError when an unknown exception occurs',
      () async {
        final exception = Exception('Unknown error');
        when(
          () => mockDatasource.getCoinHistory(coinId: coinId, epoch: epoch),
        ).thenThrow(exception);

        final result = await repository.getCoinHistory(
          coinId: coinId,
          epoch: epoch,
        );

        expect(result, isA<ResultError>());
        expect(result.error?.message, exception.toString());
        verify(
          () => mockDatasource.getCoinHistory(coinId: coinId, epoch: epoch),
        ).called(1);
      },
    );
  });
}
