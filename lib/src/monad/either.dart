sealed class Either<A, B> {
  bool isLeft() {
    return this is Left<A, B>;
  }

  bool isRight() {
    return this is Right<A, B>;
  }

  A unwrapLeft() {
    if (this is Left<A, B>) {
      return (this as Left<A, B>).value;
    } else {
      throw Exception('Cannot unwrap Right');
    }
  }

  B unwrapRight() {
    if (this is Right<A, B>) {
      return (this as Right<A, B>).value;
    } else {
      throw Exception('Cannot unwrap Left');
    }
  }

  A unwrapLeftOr(A or) {
    if (this is Left<A, B>) {
      return (this as Left<A, B>).value;
    } else {
      return or;
    }
  }

  B unwrapRightOr(B or) {
    if (this is Right<A, B>) {
      return (this as Right<A, B>).value;
    } else {
      return or;
    }
  }

  A unwrapLeftOrElse(A Function(B) orElse) {
    if (this is Left<A, B>) {
      return (this as Left<A, B>).value;
    } else {
      return orElse((this as Right<A, B>).value);
    }
  }

  B unwrapRightOrElse(B Function(A) orElse) {
    if (this is Right<A, B>) {
      return (this as Right<A, B>).value;
    } else {
      return orElse((this as Left<A, B>).value);
    }
  }

  Either<A2, B2> map<A2, B2>(Either<A2, B2> Function(A) whenLeft,
      Either<A2, B2> Function(B) whenRight) {
    if (this is Left<A, B>) {
      return whenLeft((this as Left<A, B>).value);
    } else {
      return whenRight((this as Right<A, B>).value);
    }
  }

  Either<A2, B2> mapLeftOr<A2, B2>(Either<A2, B2> Function(A) whenLeft, A or) {
    if (this is Left<A, B>) {
      return whenLeft((this as Left<A, B>).value);
    } else {
      return whenLeft(or);
    }
  }

  Either<A2, B2> mapRightOr<A2, B2>(
      Either<A2, B2> Function(B) whenRight, B or) {
    if (this is Right<A, B>) {
      return whenRight((this as Right<A, B>).value);
    } else {
      return whenRight(or);
    }
  }
}

class Left<A, B> extends Either<A, B> {
  final A value;

  Left(this.value);

  @override
  String toString() => 'Left($value)';
}

class Right<A, B> extends Either<A, B> {
  final B value;

  Right(this.value);

  @override
  String toString() => 'Right($value)';
}
