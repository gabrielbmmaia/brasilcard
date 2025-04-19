import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<dynamic> get props => [message, statusCode];
}

class UnknownException extends Equatable implements Exception {
  const UnknownException({required this.message});

  final String message;

  @override
  List<dynamic> get props => [message];
}
