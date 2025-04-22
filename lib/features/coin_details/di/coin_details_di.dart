import 'package:brasilcard/core/di/core_di.dart';
import 'package:brasilcard/features/coin_details/data/datasources/coin_details_remote_datasource.dart';
import 'package:brasilcard/features/coin_details/data/datasources/coin_history_remote_datasource.dart';
import 'package:brasilcard/features/coin_details/data/repositories/coin_details_repository.dart';
import 'package:brasilcard/features/coin_details/presentation/viewmodels/details/coin_details_viewmodel.dart';
import 'package:brasilcard/features/coin_details/presentation/viewmodels/history/coin_history_viewmodel.dart';

import '../data/repositories/coin_history_repository.dart';

class DICoinDetails {
  DICoinDetails._();

  static void inject() {
    injection
      // ViewModels
      ..registerFactory<ICoinDetailsViewModel>(
        () => CoinDetailsViewModel(injection()),
      )
      ..registerFactory<ICoinHistoryViewModel>(
        () => CoinHistoryViewModel(injection()),
      )
      // Repositories
      ..registerFactory<ICoinDetailsRepository>(
        () => CoinDetailsRepository(injection()),
      )
      ..registerFactory<ICoinHistoryRepository>(
        () => CoinHistoryRepository(injection()),
      )
      // DataSources
      ..registerFactory<ICoinDetailsRemoteDatasource>(
        () => CoinDetailsRemoteDatasource(injection()),
      )
      ..registerFactory<ICoinHistoryRemoteDatasource>(
        () => CoinHistoryRemoteDatasource(injection()),
      );
  }
}
