import 'package:pastel/pastel.dart';

class Cons<T> {
  final T value;
  final Option<Cons<T>> next;

  Cons(this.value, this.next);

  Cons.from(Iterable<T> iterable)
      : value = iterable.first,
        next = iterable.length > 1 ? Some(Cons.from(iterable.skip(1))) : None();

  Cons<T> push(T value) => Cons(value, Some(this));

  Cons<T> append(T value) {
    final list = <T>[];
    for (var item = this; item.next.isSome(); item = item.next.unwrap()) {
      list.add(item.value);
    }

    var result = Cons<T>(value, None());
    for (var element in list.reversed) {
      result = Cons<T>(element, Some(result));
    }

    return result;
  }

  Iterable<T> toIterable() sync* {
    for (var item = this;; item = item.next.unwrap()) {
      yield item.value;
      if (item.next.isNone()) {
        break;
      }
    }
  }

  @override
  String toString() => 'Cons($value, $next)';
}
