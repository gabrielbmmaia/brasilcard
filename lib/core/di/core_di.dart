import 'package:brasilcard/core/theme/viewmodel/theme_viewmodel.dart';
import 'package:brasilcard/features/coin_list/di/coin_list_di.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../services/http_service.dart';

final injection = GetIt.instance;

class CoreDI {
  CoreDI._();

  static void init() async {
    DICoinList.inject();
    injection.registerFactory<http.Client>(() => http.Client());
    injection.registerSingleton<IThemeViewModel>(ThemeViewModel());
    injection.registerFactory<IHttpClientService>(
      () => HttpClientService(injection()),
    );
  }
}
