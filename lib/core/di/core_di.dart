import 'package:brasilcard/core/theme/viewmodel/theme_viewmodel.dart';
import 'package:brasilcard/features/coin_details/di/coin_details_di.dart';
import 'package:brasilcard/features/coin_list/di/coin_list_di.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/http_service.dart';

final injection = GetIt.instance;

class CoreDI {
  CoreDI._();

  static Future<void> init() async {
    DICoinList.inject();
    DICoinDetails.inject();
    injection.registerFactory<http.Client>(() => http.Client());
    injection.registerFactory<IHttpClientService>(
      () => HttpClientService(injection()),
    );
    final sharedPreferences = await SharedPreferences.getInstance();
    injection.registerSingleton<SharedPreferences>(sharedPreferences);

    injection.registerSingleton<IThemeViewModel>(
      ThemeViewModel(sharedPreferences),
    );
  }
}
