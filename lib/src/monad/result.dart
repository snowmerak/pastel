import 'package:pastel/src/monad/error.dart';

sealed class Result<O> {
  bool isOk() {
    return this is Ok<O>;
  }

  bool isErr() {
    return this is Err<O>;
  }

  O unwrap() {
    if (this is Ok<O>) {
      return (this as Ok<O>).value;
    } else {
      throw Exception('Cannot unwrap Err');
    }
  }

  PastelError unwrapErr() {
    if (this is Err<O>) {
      return (this as Err<O>).error;
    } else {
      throw Exception('Cannot unwrap Ok');
    }
  }

  O unwrapOr(O or) {
    if (this is Ok<O>) {
      return (this as Ok<O>).value;
    } else {
      return or;
    }
  }

  O unwrapOrElse(O Function(PastelError) orElse) {
    if (this is Ok<O>) {
      return (this as Ok<O>).value;
    } else {
      return orElse((this as Err<O>).error);
    }
  }

  PastelError unwrapErrOr(PastelError or) {
    if (this is Err<O>) {
      return (this as Err<O>).error;
    } else {
      return or;
    }
  }

  PastelError unwrapErrOrElse(PastelError Function(O) orElse) {
    if (this is Err<O>) {
      return (this as Err<O>).error;
    } else {
      return orElse((this as Ok<O>).value);
    }
  }

  Result<O2> map<O2>(Result<O2> Function(O) f) {
    if (this is Ok<O>) {
      return f((this as Ok<O>).value);
    } else {
      return Err<O2>((this as Err<O>).error);
    }
  }

  Result<O2> mapOr<O2>(Result<O2> Function(O) f, Result<O2> or) {
    if (this is Ok<O>) {
      return f((this as Ok<O>).value);
    } else {
      return or;
    }
  }
}

class Ok<O> extends Result<O> {
  final O value;

  Ok(this.value);

  @override
  String toString() {
    return 'Ok($value)';
  }
}

class Err<O> extends Result<O> {
  final PastelError error;

  Err(this.error);

  @override
  String toString() {
    return 'Err($error)';
  }
}
