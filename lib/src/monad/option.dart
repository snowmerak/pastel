sealed class Option<T> {
  bool isSome() {
    return this is Some<T>;
  }

  bool isNone() {
    return this is None<T>;
  }

  T unwrap() {
    if (this is Some<T>) {
      return (this as Some<T>).value;
    } else {
      throw Exception('Cannot unwrap None');
    }
  }

  T unwrapOr(T or) {
    if (this is Some<T>) {
      return (this as Some<T>).value;
    } else {
      return or;
    }
  }

  T unwrapOrElse(T Function() orElse) {
    if (this is Some<T>) {
      return (this as Some<T>).value;
    } else {
      return orElse();
    }
  }

  Option<T2> map<T2>(Option<T2> Function(T) f) {
    if (this is Some<T>) {
      return f((this as Some<T>).value);
    } else {
      return None();
    }
  }

  Option<T2> mapOr<T2>(Option<T2> Function(T) f, T2 or) {
    if (this is Some<T>) {
      return f((this as Some<T>).value);
    } else {
      return Some(or);
    }
  }

  Option<T2> mapOrElse<T2>(Option<T2> Function(T) f, T2 Function() orElse) {
    if (this is Some<T>) {
      return f((this as Some<T>).value);
    } else {
      return Some(orElse());
    }
  }

  Option<T> or(Option<T> other) {
    if (this is Some<T>) {
      return this;
    } else {
      return other;
    }
  }

  Option<T> orElse(Option<T> Function() other) {
    if (this is Some<T>) {
      return this;
    } else {
      return other();
    }
  }
}

class Some<T> extends Option<T> {
  final T value;

  Some(this.value);

  @override
  String toString() {
    return 'Some($value)';
  }
}

class None<T> extends Option<T> {
  @override
  String toString() {
    return 'None()';
  }
}
