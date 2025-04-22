import 'package:brasilcard/core/error/base_error.dart';
import 'package:brasilcard/core/utils/result_wrapper.dart';
import 'package:brasilcard/features/coin_list/data/models/coin_model.dart';
import 'package:brasilcard/features/coin_list/data/repositories/coin_list_repository.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodels/coin_list/coin_list_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoinListRepository extends Mock implements ICoinListRepository {}

void main() {
  late CoinListViewModel viewModel;
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
  ];

  test('should append items to the paging controller on success', () async {
    when(() =>
        mockRepository.getCoinList(
          query: any(named: 'query'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        )).thenAnswer((_) async => ResultSuccess(mockCoinList));

    viewModel.init();

    final listener = viewModel.pagingController.firstPageKey;
    viewModel.pagingController.notifyPageRequestListeners(listener);

    await Future.delayed(Duration.zero);

    expect(viewModel.pagingController.itemList?.length, mockCoinList.length);
    expect(viewModel.pagingController.error, isNull);
  });

  test('should set error on paging controller when repository fails', () async {
    final error = BaseError('Erro simulado');
    when(() =>
        mockRepository.getCoinList(
          query: any(named: 'query'),
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        )).thenAnswer((_) async => ResultError(error));

    viewModel.init();

    viewModel.pagingController.notifyPageRequestListeners(0);
    await Future.delayed(Duration.zero);

    expect(viewModel.pagingController.error, error.message);
    expect(viewModel.pagingController.itemList, isNull);
  });

  test('should refresh paging controller and update query', () async {
    viewModel.refreshList(query: 'eth');

    expect(viewModel.currentQuery, 'eth');
    expect(viewModel.pagingController.itemList, isNull);
  });
}
