import 'package:brasilcard/core/error/base_error.dart';
import 'package:brasilcard/core/utils/result_wrapper.dart';
import 'package:brasilcard/features/coin_list/data/repositories/favorite_list_repository.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodels/favorite_list/favorite_list_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteListRepository extends Mock
    implements IFavoriteListRepository {}

void main() {
  late IFavoriteListViewModel viewModel;
  late MockFavoriteListRepository mockRepository;

  setUp(() {
    mockRepository = MockFavoriteListRepository();
    viewModel = FavoriteListViewModel(mockRepository);
  });

  final mockFavorites = ['bitcoin', 'ethereum'];

  group('FavoriteListViewModel Tests', () {
    group('Carregamento de favoritos', () {
      test('should load favorite coins successfully', () async {
        when(
          () => mockRepository.getFavoriteCoinsId(),
        ).thenAnswer((_) async => ResultSuccess(mockFavorites));

        await viewModel.loadFavorites();

        expect(viewModel.favoriteCoinsId, mockFavorites);
        expect(viewModel.isLoading, false);
        expect(viewModel.errorMessage, isNull);
      });

      test('should handle error during loadFavorites', () async {
        final error = BaseError('Failed to load favorites');
        when(
          () => mockRepository.getFavoriteCoinsId(),
        ).thenAnswer((_) async => ResultError(error));

        await viewModel.loadFavorites();

        expect(viewModel.errorMessage, error.message);
        expect(viewModel.isLoading, false);
      });
    });

    group('Adição e remoção de favoritos', () {
      test('should clear all favorites on unFavoriteAll success', () async {
        viewModel.favoriteCoinsId.addAll(mockFavorites);

        when(
          () => mockRepository.clearFavoriteCoins(),
        ).thenAnswer((_) async => ResultSuccessNullable(null));

        await viewModel.unFavoriteAll();

        expect(viewModel.favoriteCoinsId, isEmpty);
        expect(viewModel.isLoading, false);
      });

      test('should handle error on unFavoriteAll', () async {
        final error = BaseError('Failed to clear favorites');
        when(
          () => mockRepository.clearFavoriteCoins(),
        ).thenAnswer((_) async => ResultError(error));

        await viewModel.unFavoriteAll();

        expect(viewModel.errorMessage, error.message);
        expect(viewModel.isLoading, false);
      });

      test(
        'should remove coin if already favorite on toggleFavorite',
        () async {
          viewModel.favoriteCoinsId.addAll(['bitcoin']);

          when(
            () => mockRepository.deleteFavoriteCoin(coinId: 'bitcoin'),
          ).thenAnswer((_) async => ResultSuccessNullable(null));

          await viewModel.toggleFavorite('bitcoin');

          expect(viewModel.favoriteCoinsId.contains('bitcoin'), false);
          expect(viewModel.isLoading, false);
        },
      );

      test('should add coin if not favorite on toggleFavorite', () async {
        when(
          () => mockRepository.saveFavoriteCoins(coinId: 'ethereum'),
        ).thenAnswer((_) async => ResultSuccess(null));

        await viewModel.toggleFavorite('ethereum');

        expect(viewModel.favoriteCoinsId.contains('ethereum'), true);
        expect(viewModel.isLoading, false);
      });
    });

    group('Verificação de status de favorito', () {
      test('isFavorite should return correct status', () {
        viewModel.favoriteCoinsId.addAll(['bitcoin']);

        expect(viewModel.isFavorite('bitcoin'), true);
        expect(viewModel.isFavorite('ethereum'), false);
      });
    });
  });
}
