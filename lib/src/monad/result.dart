sealed class Result<O, E> {
  bool isOk() {
    return this is Ok<O, E>;
  }

  bool isErr() {
    return this is Err<O, E>;
  }

  O unwrap() {
    if (this is Ok<O, E>) {
      return (this as Ok<O, E>).value;
    } else {
      throw Exception('Cannot unwrap Err');
    }
  }

  E unwrapErr() {
    if (this is Err<O, E>) {
      return (this as Err<O, E>).error;
    } else {
      throw Exception('Cannot unwrap Ok');
    }
  }

  O unwrapOr(O or) {
    if (this is Ok<O, E>) {
      return (this as Ok<O, E>).value;
    } else {
      return or;
    }
  }

  O unwrapOrElse(O Function(E) orElse) {
    if (this is Ok<O, E>) {
      return (this as Ok<O, E>).value;
    } else {
      return orElse((this as Err<O, E>).error);
    }
  }

  E unwrapErrOr(E or) {
    if (this is Err<O, E>) {
      return (this as Err<O, E>).error;
    } else {
      return or;
    }
  }

  E unwrapErrOrElse(E Function(O) orElse) {
    if (this is Err<O, E>) {
      return (this as Err<O, E>).error;
    } else {
      return orElse((this as Ok<O, E>).value);
    }
  }

  Result<O2, E2> map<O2, E2>(Result<O2, E2> Function(O) f) {
    if (this is Ok<O, E>) {
      return f((this as Ok<O, E>).value);
    } else {
      return this as Err<O2, E2>;
    }
  }
}

class Ok<O, E> extends Result<O, E> {
  final O value;

  Ok(this.value);

  @override
  String toString() {
    return 'Ok($value)';
  }
}

class Err<O, E> extends Result<O, E> {
  final E error;

  Err(this.error);

  @override
  String toString() {
    return 'Err($error)';
  }
}
