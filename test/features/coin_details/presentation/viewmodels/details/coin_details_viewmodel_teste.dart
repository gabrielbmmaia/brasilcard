import 'package:brasilcard/core/error/base_error.dart';
import 'package:brasilcard/core/utils/result_wrapper.dart';
import 'package:brasilcard/features/coin_details/data/repositories/coin_details_repository.dart';
import 'package:brasilcard/features/coin_details/presentation/viewmodels/details/coin_details_viewmodel.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoinDetailsRepository extends Mock
    implements ICoinDetailsRepository {}

void main() {
  late ICoinDetailsViewModel viewModel;
  late MockCoinDetailsRepository mockRepository;

  setUp(() {
    mockRepository = MockCoinDetailsRepository();
    viewModel = CoinDetailsViewModel(mockRepository);
  });

  const coinId = 'bitcoin';
  final mockCoin = CoinModel(
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
  );

  group('CoinDetailsViewModel Tests', () {
    test('should set isLoading properly when getDetails is called', () async {
      when(() => mockRepository.getCoinDetails(coinId: coinId)).thenAnswer((
        _,
      ) async {
        await Future.delayed(const Duration(milliseconds: 10));
        return ResultSuccess(mockCoin);
      });

      final future = viewModel.getDetails(coinId: coinId);

      expect(viewModel.isLoading, true);

      await future;

      expect(viewModel.isLoading, false);
      expect(viewModel.errorMessage, isNull);
    });

    test(
      'should set crypto and isLoading when getDetails is successful',
      () async {
        when(
          () => mockRepository.getCoinDetails(coinId: coinId),
        ).thenAnswer((_) async => ResultSuccess(mockCoin));

        await viewModel.getDetails(coinId: coinId);

        expect(viewModel.crypto, mockCoin);
        expect(viewModel.errorMessage, isNull);
        expect(viewModel.isLoading, false);
      },
    );

    test(
      'should set errorMessage and isLoading when getDetails fails',
      () async {
        final exception = Exception('Failed to load coin details');
        when(
          () => mockRepository.getCoinDetails(coinId: coinId),
        ).thenAnswer((_) async => ResultError(BaseError(exception.toString())));

        await viewModel.getDetails(coinId: coinId);

        expect(viewModel.errorMessage, exception.toString());
        expect(viewModel.isLoading, false);
      },
    );
  });
}
