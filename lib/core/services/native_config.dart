import 'package:flutter/services.dart';

class NativeConfig {
  NativeConfig._();

  static const _channel = MethodChannel('com.brasilcard/config');

  static Future<String?> getApiKey() async {
    try {
      final key = await _channel.invokeMethod<String>('getApiKey');
      return key;
    } catch (e) {
      print('Erro ao buscar chave: $e');
      return null;
    }
  }
}
