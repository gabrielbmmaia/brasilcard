import 'package:brasilcard/core/utils/result_wrapper.dart';
import 'package:brasilcard/features/coin_details/data/datasources/coin_details_remote_datasource.dart';
import 'package:brasilcard/features/coin_details/data/repositories/coin_details_repository.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoinDetailsRemoteDatasource extends Mock
    implements ICoinDetailsRemoteDatasource {}

void main() {
  late ICoinDetailsRepository repository;
  late MockCoinDetailsRemoteDatasource mockRemote;

  const coinId = 'bitcoin';

  setUp(() {
    mockRemote = MockCoinDetailsRemoteDatasource();
    repository = CoinDetailsRepository(mockRemote);
  });

  group('getCoinDetails', () {
    final coinModel = CoinModel(
      id: 'bitcoin',
      name: 'Bitcoin',
      rank: '1',
      symbol: 'BTC',
      supply: 18600000,
      maxSupply: 21000000,
      marketCapUsd: 860000000000,
      volumeUsd24Hr: 32000000000,
      priceUsd: 46000,
      changePercent24Hr: 2.34,
      vwap24Hr: 45500,
      explorer: 'https://www.blockchain.com/btc',
    );

    test(
      'should return ResultSuccess with CoinModel when the remote datasource returns data',
      () async {
        when(
          () => mockRemote.getCoinDetails(coinId: coinId),
        ).thenAnswer((_) async => coinModel);

        final result = await repository.getCoinDetails(coinId: coinId);

        expect(result, isA<ResultSuccess<CoinModel>>());
        final successResult = result as ResultSuccess<CoinModel>;
        expect(successResult.data.id, 'bitcoin');
        expect(successResult.data.name, 'Bitcoin');
        expect(successResult.data.supply, 18600000);
        expect(successResult.data.maxSupply, 21000000);
        expect(successResult.data.priceUsd, 46000);
        expect(successResult.data.explorer, 'https://www.blockchain.com/btc');
        verify(() => mockRemote.getCoinDetails(coinId: coinId)).called(1);
      },
    );

    test(
      'should return ResultError when the remote datasource throws an exception',
      () async {
        when(
          () => mockRemote.getCoinDetails(coinId: coinId),
        ).thenThrow(Exception('Some error'));

        final result = await repository.getCoinDetails(coinId: coinId);

        expect(result, isA<ResultError>());
        final errorResult = result as ResultError;
        expect(errorResult.error.message, 'Exception: Some error');
        verify(() => mockRemote.getCoinDetails(coinId: coinId)).called(1);
      },
    );
  });
}
