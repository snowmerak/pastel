import 'package:pastel/src/monad/result.dart';

class Scope<T> {
  final T _state;

  Scope(this._state);

  T get state => _state;

  Result<R> let<R>(Result<R> Function(T) f) => f(_state);
}
