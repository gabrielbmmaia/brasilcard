class BaseError extends Error {
  final String message;

  BaseError(this.message);

  @override
  String toString() => message;
}
