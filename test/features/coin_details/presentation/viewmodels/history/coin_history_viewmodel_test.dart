import 'package:brasilcard/core/error/base_error.dart';
import 'package:brasilcard/core/utils/result_wrapper.dart';
import 'package:brasilcard/features/coin_details/data/models/graph_epoch.dart';
import 'package:brasilcard/features/coin_details/data/models/graph_model.dart';
import 'package:brasilcard/features/coin_details/data/repositories/coin_history_repository.dart';
import 'package:brasilcard/features/coin_details/presentation/viewmodels/history/coin_history_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoinHistoryRepository extends Mock
    implements ICoinHistoryRepository {}

void main() {
  late ICoinHistoryViewModel viewModel;
  late MockCoinHistoryRepository mockRepository;

  final mockEpoch = GraphEpoch.last90Days();

  setUp(() {
    mockRepository = MockCoinHistoryRepository();
    viewModel = CoinHistoryViewModel(mockRepository);
    registerFallbackValue(mockEpoch);
  });

  const coinId = 'bitcoin';
  final mockHistory = [
    GraphModel(
      priceUsd: 50000,
      time: 1000,
      date: DateTime.now().millisecond.toString(),
    ),
    GraphModel(
      priceUsd: 51000,
      time: 1500,
      date: DateTime.now().millisecond.toString(),
    ),
  ];

  group('CoinHistoryViewModel Tests', () {
    test('should set isLoading true then false during fetchHistory', () async {
      when(
        () => mockRepository.getCoinHistory(
          coinId: any(named: 'coinId'),
          epoch: any(named: 'epoch'),
        ),
      ).thenAnswer((_) async => ResultSuccess(mockHistory));

      final future = viewModel.fetchHistory(coinId: coinId);

      expect(viewModel.isLoading, true);

      await future;

      expect(viewModel.isLoading, false);
    });

    test('should populate history on successful fetchHistory', () async {
      when(
        () => mockRepository.getCoinHistory(
          coinId: any(named: 'coinId'),
          epoch: any(named: 'epoch'),
        ),
      ).thenAnswer((_) async => ResultSuccess(mockHistory));

      await viewModel.fetchHistory(coinId: coinId);

      expect(viewModel.history.length, mockHistory.length);
      expect(viewModel.errorMessage, isNull);
    });

    test('should set errorMessage on failed fetchHistory', () async {
      final error = BaseError('Failed to load history');
      when(
        () => mockRepository.getCoinHistory(
          coinId: any(named: 'coinId'),
          epoch: any(named: 'epoch'),
        ),
      ).thenAnswer((_) async => ResultError(error));

      await viewModel.fetchHistory(coinId: coinId);

      expect(viewModel.errorMessage, error.message);
      expect(viewModel.history, isEmpty);
      expect(viewModel.isLoading, false);
    });

    test('should update epoch if newEpoch is passed', () async {
      final newEpoch = GraphEpoch.last180Days();
      when(
        () => mockRepository.getCoinHistory(
          coinId: any(named: 'coinId'),
          epoch: newEpoch,
        ),
      ).thenAnswer((_) async => ResultSuccess(mockHistory));

      await viewModel.fetchHistory(coinId: coinId, newEpoch: newEpoch);

      expect(viewModel.epoch, newEpoch);
    });
  });
}
