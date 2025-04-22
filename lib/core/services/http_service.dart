import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../error/exception.dart';
import 'native_config.dart';

abstract class IHttpClientService {
  Future<Map<String, dynamic>> get(String url);
}

class HttpClientService implements IHttpClientService {
  const HttpClientService(this.client);

  final http.Client client;
  final kBaseUrl = 'https://rest.coincap.io/v3';

  @override
  Future<Map<String, dynamic>> get(String url) async {
    try {
      final containsApiKey = url.contains('apiKey=');
      String mappedUrl = '$kBaseUrl$url';

      if (!containsApiKey) {
        final apiKey = await NativeConfig.getApiKey();
        final hasQueryParams = mappedUrl.contains('?');
        final separator = hasQueryParams ? '&' : '?';
        mappedUrl += '${separator}apiKey=$apiKey';
      }

      final uri = Uri.parse(mappedUrl);
      final response = await client.get(uri);
      if (response.statusCode != HttpStatus.ok) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return jsonDecode(response.body);
    } on SocketException {
      throw NoInternetException(message: 'Sem conexão com a internet');
    } on ServerException {
      rethrow;
    } catch (e) {
      throw UnknownException(message: 'Erro desconhecido');
    }
  }
}
