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

void main() => Scope((
      content: Scope((filename: "pubspec.yaml"))
          .let((p) => Ok(File(p.filename)).map((file) {
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
              }))
    ))
        .let((p) => Some(match<Result<String>, String>((p0) => p0.isOk(),
            (p0) => p0.unwrap(), (p0) => p0.unwrapErr().toString())(p.content)))
        .map((p0) => print(p0));
