Iterable<int> numbers(int start, int end, {int step = 1}) sync* {
  for (int i = start; i <= end; i += step) {
    yield i;
  }
}
