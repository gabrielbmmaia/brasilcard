import 'package:brasilcard/core/error/base_error.dart';
import 'package:brasilcard/core/utils/result_wrapper.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';
import 'package:brasilcard/features/coin_list/data/repositories/coin_list_repository.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodels/coin_list_from_ids/coin_list_from_ids_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoinListRepository extends Mock implements ICoinListRepository {}

void main() {
  late ICoinListFromIdsViewModel viewModel;
  late MockCoinListRepository mockRepository;

  setUp(() {
    mockRepository = MockCoinListRepository();
    viewModel = CoinListFromIdsViewModel(mockRepository);
  });

  const ids = ['bitcoin', 'ethereum'];

  final mockCoinList = [
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
      maxSupply: null,
      marketCapUsd: 400000000000,
      volumeUsd24Hr: 20000000000,
      priceUsd: 3500,
      changePercent24Hr: 1.78,
      vwap24Hr: 3480,
      explorer: 'https://ethereum.org',
    ),
  ];

  group('CoinListFromIdsViewModel Tests', () {
    test('should set isLoading true then false during getCryptos', () async {
      when(
        () => mockRepository.getCoinListFromIds(ids: ids),
      ).thenAnswer((_) async => ResultSuccess(mockCoinList));

      final future = viewModel.getCryptos(ids: ids);

      expect(viewModel.isLoading, true);

      await future;

      expect(viewModel.isLoading, false);
    });

    test('should populate cryptos on successful getCryptos', () async {
      when(
        () => mockRepository.getCoinListFromIds(ids: ids),
      ).thenAnswer((_) async => ResultSuccess(mockCoinList));

      await viewModel.getCryptos(ids: ids);

      expect(viewModel.cryptos.length, mockCoinList.length);
      expect(viewModel.errorMessage, isNull);
    });

    test('should set errorMessage on failed getCryptos', () async {
      final error = BaseError('Failed to load coins');
      when(
        () => mockRepository.getCoinListFromIds(ids: ids),
      ).thenAnswer((_) async => ResultError(error));

      await viewModel.getCryptos(ids: ids);

      expect(viewModel.errorMessage, error.message);
      expect(viewModel.cryptos, isEmpty);
      expect(viewModel.isLoading, false);
    });

    test('should remove coin correctly', () async {
      viewModel.cryptos.addAll(mockCoinList);

      viewModel.removeCoin('bitcoin');

      expect(viewModel.cryptos.any((c) => c.id == 'bitcoin'), false);
      expect(viewModel.cryptos.any((c) => c.id == 'ethereum'), true);
    });

    test('should clear all coins with clearCoins', () async {
      viewModel.cryptos.addAll(mockCoinList);

      viewModel.clearCoins();

      expect(viewModel.cryptos, isEmpty);
    });
  });
}
