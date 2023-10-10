class Reactive<T> {
  final Map<int, Function(T)> _listeners = {};

  T _value;

  Reactive(this._value);

  T get read => _value;

  set write(T value) {
    _value = value;
    notify();
  }

  void listen(Object parent, void Function(T) listener) {
    _listeners[parent.hashCode] = listener;
  }

  void unlisten(Object parent) {
    _listeners.remove(parent.hashCode);
  }

  void notify() {
    _listeners.forEach((key, listener) => listener(_value));
  }
}
