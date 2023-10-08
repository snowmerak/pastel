import 'package:pastel/src/monad/error.dart';
import 'package:pastel/src/monad/result.dart';

Result<O> catchException<O>(O Function() f) {
  try {
    return Ok(f());
  } catch (e) {
    return Err(StringError(e.toString()));
  }
}
