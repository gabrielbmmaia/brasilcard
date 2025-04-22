import 'package:brasilcard/core/utils/result_wrapper.dart';
import 'package:brasilcard/features/coin_list/data/datasources/local/favorite_coins_local_datasource.dart';
import 'package:brasilcard/features/coin_list/data/repositories/favorite_list_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteCoinsLocalDatasource extends Mock
    implements IFavoriteCoinsLocalDatasource {}

void main() {
  late FavoriteListRepository repository;
  late MockFavoriteCoinsLocalDatasource mockLocalDatasource;

  setUp(() {
    mockLocalDatasource = MockFavoriteCoinsLocalDatasource();
    repository = FavoriteListRepository(mockLocalDatasource);
  });

  final kException = Exception('Error');
  const coinId = 'bitcoin';

  group('saveFavoriteCoins', () {
    test(
      'should save coin to favorites when local datasource is successful',
      () async {
        when(
          () => mockLocalDatasource.saveFavoriteCoin(coinId: coinId),
        ).thenAnswer((_) async => Future.value());

        final result = await repository.saveFavoriteCoins(coinId: coinId);

        expect(result, isA<ResultSuccessNullable>());
        verify(
          () => mockLocalDatasource.saveFavoriteCoin(coinId: coinId),
        ).called(1);
      },
    );

    test(
      'should return ResultError when local datasource throws an error',
      () async {
        when(
          () => mockLocalDatasource.saveFavoriteCoin(coinId: coinId),
        ).thenThrow(kException);

        final result = await repository.saveFavoriteCoins(coinId: coinId);

        expect(result, isA<ResultError>());
        expect((result as ResultError).error.message, kException.toString());
        verify(
          () => mockLocalDatasource.saveFavoriteCoin(coinId: coinId),
        ).called(1);
      },
    );
  });

  group('getFavoriteCoinsId', () {
    test(
      'should return a list of favorite coin ids when local datasource is successful',
      () async {
        final favoriteCoins = ['bitcoin', 'ethereum'];
        when(
          () => mockLocalDatasource.getFavoriteCoinsId(),
        ).thenAnswer((_) => favoriteCoins);

        final result = await repository.getFavoriteCoinsId();

        expect(result, isA<ResultSuccess<List<String>>>());
        expect(result.data, favoriteCoins);
        verify(() => mockLocalDatasource.getFavoriteCoinsId()).called(1);
      },
    );

    test(
      'should return ResultError when local datasource throws an error',
      () async {
        when(
          () => mockLocalDatasource.getFavoriteCoinsId(),
        ).thenThrow(kException);

        final result = await repository.getFavoriteCoinsId();

        expect(result, isA<ResultError>());
        expect((result as ResultError).error.message, kException.toString());
        verify(() => mockLocalDatasource.getFavoriteCoinsId()).called(1);
      },
    );
  });

  group('deleteFavoriteCoin', () {
    test(
      'should delete coin from favorites when local datasource is successful',
      () async {
        when(
          () => mockLocalDatasource.deleteFavoriteCoin(coinId: coinId),
        ).thenAnswer((_) async => Future.value());

        final result = await repository.deleteFavoriteCoin(coinId: coinId);

        expect(result, isA<ResultSuccessNullable>());
        verify(
          () => mockLocalDatasource.deleteFavoriteCoin(coinId: coinId),
        ).called(1);
      },
    );

    test(
      'should return ResultError when local datasource throws an error',
      () async {
        when(
          () => mockLocalDatasource.deleteFavoriteCoin(coinId: coinId),
        ).thenThrow(kException);

        final result = await repository.deleteFavoriteCoin(coinId: coinId);

        expect(result, isA<ResultError>());
        expect((result as ResultError).error.message, kException.toString());
        verify(
          () => mockLocalDatasource.deleteFavoriteCoin(coinId: coinId),
        ).called(1);
      },
    );
  });

  group('clearFavoriteCoins', () {
    test(
      'should clear all favorite coins when local datasource is successful',
      () async {
        when(
          () => mockLocalDatasource.clearFavoriteCoins(),
        ).thenAnswer((_) async => Future.value());

        final result = await repository.clearFavoriteCoins();

        expect(result, isA<ResultSuccessNullable>());
        verify(() => mockLocalDatasource.clearFavoriteCoins()).called(1);
      },
    );

    test(
      'should return ResultError when local datasource throws an error',
      () async {
        when(
          () => mockLocalDatasource.clearFavoriteCoins(),
        ).thenThrow(kException);

        final result = await repository.clearFavoriteCoins();

        expect(result, isA<ResultError>());
        expect((result as ResultError).error.message, kException.toString());
        verify(() => mockLocalDatasource.clearFavoriteCoins()).called(1);
      },
    );
  });
}
