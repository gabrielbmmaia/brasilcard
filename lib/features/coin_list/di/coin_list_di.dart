import 'package:brasilcard/core/di/core_di.dart';
import 'package:brasilcard/features/coin_list/data/datasources/remote/search_coins_remote_datasource.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodel/coin_list/coin_list_viewmodel.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodel/coin_list_from_ids/coin_list_from_ids_viewmodel.dart';
import 'package:brasilcard/features/coin_list/repositories/coin_list_repository.dart';

import '../data/datasources/local/favorite_coins_local_datasource.dart';

class DICoinList {
  DICoinList._();

  static Future<void> inject() async {
    injection
      ..registerFactory<ICoinListViewModel>(
        () => CoinListViewModel(injection()),
      )
      ..registerFactory<ICoinListFromIdsViewModel>(
        () => CoinListFromIdsViewModel(injection()),
      )
      ..registerFactory<ICoinListRepository>(
        () => CoinListRepository(injection()),
      )
      ..registerFactory<ISearchCoinsRemoteDatasource>(
        () => SearchCoinsRemoteDatasource(injection()),
      )
      ..registerFactory<IFavoriteCoinsLocalDatasource>(
        () => FavoriteCoinsLocalDatasource(injection()),
      );
  }
}
