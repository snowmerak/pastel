class Scope<T> {
  final T _state;

  Scope(this._state);

  T get state => _state;

  R let<R>(R Function(T) f) => f(_state);
}
