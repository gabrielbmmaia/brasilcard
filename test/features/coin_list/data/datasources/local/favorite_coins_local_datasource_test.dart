import 'package:brasilcard/features/coin_list/data/datasources/local/favorite_coins_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

class MockHiveBox extends Mock implements Box<String> {}

void main() {
  late FavoriteCoinsLocalDatasource datasource;
  late MockHiveBox mockBox;

  const coinId = 'bitcoin';

  setUp(() {
    mockBox = MockHiveBox();
    datasource = FavoriteCoinsLocalDatasource(mockBox);
  });

  group('saveFavoriteCoin', () {
    test('should save coin if not already in box', () async {
      when(() => mockBox.containsKey(coinId)).thenReturn(false);
      when(() => mockBox.put(coinId, coinId)).thenAnswer((_) async => {});

      await datasource.saveFavoriteCoin(coinId: coinId);

      verify(() => mockBox.containsKey(coinId)).called(1);
      verify(() => mockBox.put(coinId, coinId)).called(1);
    });

    test('should not save coin if it already exists', () async {
      when(() => mockBox.containsKey(coinId)).thenReturn(true);

      await datasource.saveFavoriteCoin(coinId: coinId);

      verify(() => mockBox.containsKey(coinId)).called(1);
      verifyNever(() => mockBox.put(any(), any()));
    });
  });

  group('getFavoriteCoinsId', () {
    test('should return all values in the box', () {
      when(() => mockBox.values).thenReturn(['bitcoin', 'ethereum']);

      final result = datasource.getFavoriteCoinsId();

      expect(result, ['bitcoin', 'ethereum']);
      verify(() => mockBox.values).called(1);
    });
  });

  group('deleteFavoriteCoin', () {
    test('should delete coin from box', () async {
      when(() => mockBox.delete(coinId)).thenAnswer((_) async => {});

      await datasource.deleteFavoriteCoin(coinId: coinId);

      verify(() => mockBox.delete(coinId)).called(1);
    });
  });

  group('clearFavoriteCoins', () {
    test('should clear the entire box', () async {
      when(() => mockBox.clear()).thenAnswer((_) async => 0);

      await datasource.clearFavoriteCoins();

      verify(() => mockBox.clear()).called(1);
    });
  });
}
