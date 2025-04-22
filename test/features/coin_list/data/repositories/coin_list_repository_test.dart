import 'package:brasilcard/core/utils/result_wrapper.dart';
import 'package:brasilcard/features/coin_list/data/datasources/remote/search_coins_remote_datasource.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';
import 'package:brasilcard/features/coin_list/data/repositories/coin_list_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchCoinsRemoteDatasource extends Mock
    implements ISearchCoinsRemoteDatasource {}

void main() {
  late CoinListRepository repository;
  late MockSearchCoinsRemoteDatasource mockRemoteDatasource;

  setUp(() {
    mockRemoteDatasource = MockSearchCoinsRemoteDatasource();
    repository = CoinListRepository(mockRemoteDatasource);
  });

  final mockCoins = [
    CoinModel(
      id: 'bitcoin',
      rank: '1',
      symbol: 'BTC',
      name: 'Bitcoin',
      supply: 18600000,
      maxSupply: 21000000,
      marketCapUsd: 860000000000,
      volumeUsd24Hr: 32000000000,
      priceUsd: 46000,
      changePercent24Hr: 2.34,
      vwap24Hr: 45500,
      explorer: 'https://bitcoin.org',
    ),
    CoinModel(
      id: 'ethereum',
      rank: '2',
      symbol: 'ETH',
      name: 'Ethereum',
      supply: 115000000,
      maxSupply: 120000000,
      marketCapUsd: 200000000000,
      volumeUsd24Hr: 15000000000,
      priceUsd: 3000,
      changePercent24Hr: 1.5,
      vwap24Hr: 2950,
      explorer: 'https://ethereum.org',
    ),
  ];

  final kException = Exception('Error');

  group('getCoinList', () {
    const query = 'bitcoin';

    test(
      'should return a list of coins when remote datasource is successful',
      () async {
        when(
          () => mockRemoteDatasource.getCoinList(query: query),
        ).thenAnswer((_) async => mockCoins);

        final result = await repository.getCoinList(query: query);

        expect(result, isA<ResultSuccess<List<CoinModel>>>());
        expect(result.data, mockCoins);
        verify(() => mockRemoteDatasource.getCoinList(query: query)).called(1);
      },
    );

    test(
      'should return ResultError when remote datasource throws an error',
      () async {
        when(
          () => mockRemoteDatasource.getCoinList(query: query),
        ).thenThrow(kException);

        final result = await repository.getCoinList(query: query);

        expect(result, isA<ResultError>());
        expect((result as ResultError).error.message, kException.toString());
        verify(() => mockRemoteDatasource.getCoinList(query: query)).called(1);
      },
    );
  });

  group('getCoinListFromIds', () {
    const ids = ['bitcoin', 'ethereum'];

    test(
      'should return a list of coins when remote datasource is successful',
      () async {
        when(
          () => mockRemoteDatasource.getCoinListFromIds(coinIds: ids),
        ).thenAnswer((_) async => mockCoins);

        final result = await repository.getCoinListFromIds(ids: ids);

        expect(result, isA<ResultSuccess<List<CoinModel>>>());
        expect(result.data, mockCoins);
        verify(
          () => mockRemoteDatasource.getCoinListFromIds(coinIds: ids),
        ).called(1);
      },
    );

    test(
      'should return ResultError when remote datasource throws an error',
      () async {
        when(
          () => mockRemoteDatasource.getCoinListFromIds(coinIds: ids),
        ).thenThrow(kException);

        final result = await repository.getCoinListFromIds(ids: ids);

        expect(result, isA<ResultError>());
        expect((result as ResultError).error.message, kException.toString());
        verify(
          () => mockRemoteDatasource.getCoinListFromIds(coinIds: ids),
        ).called(1);
      },
    );

    test('should return empty list if no ids are provided', () async {
      final emptyIds = <String>[];

      final result = await repository.getCoinListFromIds(ids: emptyIds);

      expect(result, isA<ResultSuccess<List<CoinModel>>>());
      expect((result as ResultSuccess).data, isEmpty);
    });
  });
}
