import 'package:pastel/pastel.dart';

void main() {
  // Result
  Result<int> result = Ok(1);

  print(result.isOk()); // true

  print(result.map((p0) => Ok(p0 + 1))); // Ok(2)
}
