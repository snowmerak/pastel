import 'package:pastel/pastel.dart';
import 'package:test/test.dart';

void main() {
  group('Monad Test', () {
    test('Result int ok', () {
      Result<int, String> result = Ok(1);

      expect(result.isOk(), true);
      expect(result.isErr(), false);
      expect(result.unwrap(), 1);
      expect(result.unwrapOr(2), 1);
      expect(result.unwrapOrElse((e) => 2), 1);
    });

    test('Result int error', () {
      Result<int, String> result = Err('error');

      expect(result.isOk(), false);
      expect(result.isErr(), true);
      expect(() => result.unwrap(), throwsException);
      expect(result.unwrapOr(2), 2);
      expect(result.unwrapOrElse((e) => 2), 2);
    });

    test('Result int map', () {
      Result<int, String> ok = Ok(1);

      expect(ok.map((p0) => Ok<int, String>(p0 + 1)).unwrap(), 2);

      Result<int, String> err = Err('error');

      expect(err.map((p0) => Ok<int, String>(p0 + 1)).unwrapErr(), 'error');
      expect(err.map((p0) => Ok<int, String>(p0 + 1)).unwrapOr(-1), -1);
    });
  });
}
