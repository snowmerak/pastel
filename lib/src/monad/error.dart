abstract class PastelError {}

class ExceptionError extends PastelError {
  final Exception exception;

  ExceptionError(this.exception);

  @override
  String toString() => exception.toString();
}

class StringError extends PastelError {
  final String message;

  StringError(this.message);

  @override
  String toString() => message;
}
