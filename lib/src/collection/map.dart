import 'package:pastel/pastel.dart';

class ImmutableMap<K, V> {
  final Map<K, V> _map;

  ImmutableMap(this._map);

  factory ImmutableMap.from(Map<K, V> map) {
    return ImmutableMap(Map.from(map));
  }

  factory ImmutableMap.empty() {
    return ImmutableMap({});
  }

  factory ImmutableMap.of(Iterable<(K, V)> iterable) {
    final result = ImmutableMap<K, V>.empty();
    for (var entry in iterable) {
      result.set(entry.$1, entry.$2);
    }
    return result;
  }

  Option<V> get(K key) {
    final value = _map[key];
    return value == null ? None() : Some(value);
  }

  ImmutableMap<K, V> set(K key, V value) {
    return ImmutableMap(Map.from(_map)..[key] = value);
  }

  ImmutableMap<K, V> remove(K key) {
    return ImmutableMap(Map.from(_map)..remove(key));
  }

  Iterable<(K, V)> entries() sync* {
    for (var entry in _map.entries) {
      yield (entry.key, entry.value);
    }
  }

  Iterable<K> keys() sync* {
    for (var key in _map.keys) {
      yield key;
    }
  }

  Iterable<V> values() sync* {
    for (var value in _map.values) {
      yield value;
    }
  }
}
