Iterable<(int, T)> generator<T>(T Function(int, T) f, T initial) sync* {
  int i = 0;
  T current = initial;
  while (true) {
    yield (i, current);
    current = f(i, current);
    i++;
  }
}
