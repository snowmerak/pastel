Iterable<T> comprehensive<T>(
    Iterable<T> iterable, bool Function(T) test) sync* {
  for (var i in iterable) {
    if (test(i)) {
      yield i;
    }
  }
}
