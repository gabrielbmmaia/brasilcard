import 'package:brasilcard/core/di/core_di.dart';
import 'package:brasilcard/features/coin_list/data/datasources/remote/search_coins_remote_datasource.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodels/coin_list/coin_list_viewmodel.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodels/coin_list_from_ids/coin_list_from_ids_viewmodel.dart';
import 'package:brasilcard/features/coin_list/presentation/viewmodels/favorite_list/favorite_list_viewmodel.dart';

import '../data/datasources/local/favorite_coins_local_datasource.dart';
import '../data/repositories/coin_list_repository.dart';
import '../data/repositories/favorite_list_repository.dart';

class DICoinList {
  DICoinList._();

  static void inject() {
    injection
      // ViewModels
      ..registerFactory<ICoinListViewModel>(
        () => CoinListViewModel(injection()),
      )
      ..registerFactory<IFavoriteListViewModel>(
        () => FavoriteListViewModel(injection()),
      )
      ..registerFactory<ICoinListFromIdsViewModel>(
        () => CoinListFromIdsViewModel(injection()),
      )
      // Repositories
      ..registerFactory<ICoinListRepository>(
        () => CoinListRepository(injection()),
      )
      ..registerFactory<IFavoriteListRepository>(
        () => FavoriteListRepository(injection()),
      )
      // DataSources
      ..registerFactory<ISearchCoinsRemoteDatasource>(
        () => SearchCoinsRemoteDatasource(injection()),
      )
      ..registerFactory<IFavoriteCoinsLocalDatasource>(
        () => FavoriteCoinsLocalDatasource(),
      );
  }
}
