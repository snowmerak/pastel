import 'dart:io';

import 'package:pastel/pastel.dart';

class FileNotExistsError extends PastelError {
  final String path;

  FileNotExistsError(this.path);

  @override
  String toString() => 'File $path does not exist';
}

class FileSystemError extends PastelError {
  final FileSystemException exception;

  FileSystemError(this.exception);

  @override
  String toString() => exception.toString();
}

void main() {
  var result = Ok(File('pubspec.yaml')).map((file) {
    if (file.existsSync()) {
      return Ok(file);
    } else {
      return Err<File>(FileNotExistsError(file.path));
    }
  }).map((file) {
    try {
      return Ok(file.readAsStringSync());
    } on FileSystemException catch (e) {
      return Err<String>(FileSystemError(e));
    }
  });

  switch (result) {
    case Ok<String>():
      print(result.unwrap());
      break;
    case Err<String>():
      print(result.unwrapErr());
      break;
  }
}
