R Function(T) cond<T, R>(
    List<(bool Function(T), R Function(T))> cases, R Function(T) otherwise) {
  return (T value) {
    for (var (criteria, whenTrue) in cases) {
      if (criteria(value)) {
        return whenTrue(value);
      }
    }
    return otherwise(value);
  };
}

R Function(T) match<T, R>(bool Function(T) criteria, R Function(T) whenTrue,
    R Function(T) whenFalse) {
  return (T value) {
    if (criteria(value)) {
      return whenTrue(value);
    } else {
      return whenFalse(value);
    }
  };
}

R Function(T) when<T, R>(
    List<(T, R Function(T))> cases, R Function(T) otherwise) {
  final table = Map.fromEntries(cases.map((e) => MapEntry(e.$1, e.$2)));
  return (T value) {
    if (table.containsKey(value)) {
      return table[value]!(value);
    } else {
      return otherwise(value);
    }
  };
}
