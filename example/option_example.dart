import 'package:pastel/pastel.dart';

void main() {
  Option<int> option = Some(1);

  print(option.isSome()); // true
  print(option.map((p0) => p0 + 1)); // Some(2)

  option = None<int>();

  print(option.isNone()); // true
  print(option.map((p0) => p0 + 1)); // None()
}
