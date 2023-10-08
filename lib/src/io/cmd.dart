import 'dart:io';

import 'package:pastel/src/io/error.dart';
import 'package:pastel/src/monad/result.dart';

Result<String> getHome() {
  final home = Platform.environment['HOME'];
  if (home == null) {
    return Err(EnvironmentNotFoundError('HOME'));
  }
  return Ok(home);
}

Result<String> isExists(String path) {
  try {
    final file = File(path);
    final exists = file.existsSync();
    if (exists) {
      return Ok(path);
    } else {
      return Err(FileNotFoundError(path));
    }
  } catch (e) {
    return Err(FileNotFoundError(path));
  }
}
