import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<dynamic> get props => [message, statusCode];

  @override
  String toString() => '$statusCode, message: $message';
}

class UnknownException extends Equatable implements Exception {
  const UnknownException({required this.message});

  final String message;

  @override
  List<dynamic> get props => [message];

  @override
  String toString() => message;
}

class NoInternetException extends Equatable implements Exception {
  const NoInternetException({required this.message});

  final String message;

  @override
  List<dynamic> get props => [message];

  @override
  String toString() => message;
}
