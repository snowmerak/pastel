import 'package:pastel/pastel.dart';
import 'package:pastel/src/monad/catch.dart';

void main() {
  PastelError err = StringError('a string error');
  // override toString
  print(err);

  Result<int> result =
      catchException<int>(() => throw Exception('an exception'));

  switch (result) {
    case Ok<int>():
      print('ok');
      break;
    case Err<int>():
      switch (result.unwrapErr()) {
        case ExceptionError():
          print('exception');
          break;
        case StringError():
          print('string');
          break;
      }
      break;
  }
}
