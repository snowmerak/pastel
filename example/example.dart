import 'package:pastel/pastel.dart';

void main() {
  print(Scope((a: 100, b: 200)).let((p) => Ok(p.a + p.b)).unwrap());
}
