import 'package:brasilcard/core/error/base_error.dart';
import 'package:brasilcard/core/utils/result_wrapper.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';
import 'package:brasilcard/features/coin_list/data/repositories/coin_list_repository.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodels/coin_list/coin_list_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoinListRepository extends Mock implements ICoinListRepository {}

void main() {
  late ICoinListViewModel viewModel;
  late MockCoinListRepository mockRepository;

  setUp(() {
    mockRepository = MockCoinListRepository();
    viewModel = CoinListViewModel(mockRepository);
  });

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

  group('CoinListViewModel Tests', () {
    test('should set isLoading true then false during getCryptos', () async {
      when(
        () => mockRepository.getCoinList(query: null),
      ).thenAnswer((_) async => ResultSuccess(mockCoinList));

      final future = viewModel.getCryptos();

      expect(viewModel.isLoading, true);

      await future;

      expect(viewModel.isLoading, false);
    });

    test('should populate cryptos on successful getCryptos', () async {
      when(
        () => mockRepository.getCoinList(query: null),
      ).thenAnswer((_) async => ResultSuccess(mockCoinList));

      await viewModel.getCryptos();

      expect(viewModel.cryptos.length, mockCoinList.length);
      expect(viewModel.errorMessage, isNull);
    });

    test('should set errorMessage on failed getCryptos', () async {
      final error = BaseError('Failed to fetch coins');
      when(
        () => mockRepository.getCoinList(query: null),
      ).thenAnswer((_) async => ResultError(error));

      await viewModel.getCryptos();

      expect(viewModel.errorMessage, error.message);
      expect(viewModel.cryptos, isEmpty);
      expect(viewModel.isLoading, false);
    });

    test('should pass query parameter to repository on getCryptos', () async {
      const query = 'bit';
      when(
        () => mockRepository.getCoinList(query: query),
      ).thenAnswer((_) async => ResultSuccess(mockCoinList));

      await viewModel.getCryptos(query: query);

      verify(() => mockRepository.getCoinList(query: query)).called(1);
    });
  });
}
