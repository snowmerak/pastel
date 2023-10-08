import 'package:pastel/src/collection/map.dart';

class ImmutableList<T> {
  final List<T> _list;

  ImmutableList(this._list);

  ImmutableList.from(Iterable<T> iterable) : _list = List.from(iterable);

  ImmutableList<T> push(T value) => ImmutableList([value, ..._list]);

  ImmutableList<T> pop() => ImmutableList.from(_list.take(_list.length - 1));

  ImmutableList<T> unshift(T value) => ImmutableList([..._list, value]);

  ImmutableList<T> shift() => ImmutableList.from(_list.skip(1));

  ImmutableMap<int, T> entries() {
    final map = <int, T>{};
    for (var i = 0; i < _list.length; i++) {
      map[i] = _list[i];
    }
    return ImmutableMap.from(map);
  }

  Iterable<T> toIterable() sync* {
    for (var item in _list) {
      yield item;
    }
  }

  @override
  String toString() => 'ImmutableList($_list)';
}
