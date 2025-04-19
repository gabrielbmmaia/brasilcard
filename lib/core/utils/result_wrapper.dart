import '../error/base_error.dart';

abstract class Result<T> {
  const Result();

  bool get isSuccess => this is ResultSuccess<T>;

  T? get data => isSuccess ? (this as ResultSuccess<T>).data : null;

  BaseError? get error =>
      this is ResultError<T> ? (this as ResultError<T>).error : null;

  R when<R>({
    required R Function(T data) success,
    required R Function(BaseError error) error,
  }) {
    if (this is ResultSuccess<T>) {
      return success((this as ResultSuccess<T>).data);
    } else if (this is ResultError<T>) {
      return error((this as ResultError<T>).error);
    } else {
      throw StateError('Invalid call to when(): expected ResultSuccess or ResultError');
    }
  }

  R whenNullable<R>({
    required R Function(T? data) success,
    required R Function(BaseError error) error,
  }) {
    if (this is ResultSuccessNullable<T>) {
      return success((this as ResultSuccessNullable<T>).data);
    } else if (this is ResultError<T>) {
      return error((this as ResultError<T>).error);
    } else {
      throw StateError('Invalid call to whenNullable(): expected ResultSuccessNullable or ResultError');
    }
  }
}


class ResultSuccess<T> extends Result<T> {
  @override
  final T data;

  const ResultSuccess(this.data);
}

class ResultSuccessNullable<T> extends Result<T> {
  @override
  final T? data;

  const ResultSuccessNullable([this.data]);
}

class ResultError<T> extends Result<T> {
  @override
  final BaseError error;

  const ResultError(this.error);
}
