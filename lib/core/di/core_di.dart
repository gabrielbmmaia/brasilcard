import 'package:brasilcard/features/coin_list/di/coin_list_di.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../network/http_client.dart';

final injection = GetIt.instance;

class CoreDI {
  CoreDI._();

  static Future<void> init() async {
    injection
      ..registerFactory<http.Client>(() => http.Client())
      ..registerFactory<IHttpClientService>(
        () => HttpClientService(injection()),
      );
    await DICoinList.inject();
  }
}
