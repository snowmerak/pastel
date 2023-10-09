class Reactive<T> {
  final Map<int, Function(T)> _listeners = {};

  T _value;

  Reactive(this._value);

  T get read => _value;

  set write(T value) {
    _value = value;
    _listeners.forEach((key, listener) => listener(value));
  }

  void listen(Object parent, void Function(T) listener) {
    _listeners[parent.hashCode] = listener;
  }
}
