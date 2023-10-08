import 'package:pastel/src/monad/error.dart';

class EnvironmentNotFoundError extends PastelError {
  final String key;

  EnvironmentNotFoundError(this.key);

  @override
  String toString() => 'Environment variable $key not found';
}

class FileNotFoundError extends PastelError {
  final String path;

  FileNotFoundError(this.path);

  @override
  String toString() => '\'$path\' not found';
}
