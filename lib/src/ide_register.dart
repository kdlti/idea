class IdeRegister {
  static final IdeRegister _instance = IdeRegister._internal();

  factory IdeRegister() {
    return _instance;
  }

  IdeRegister._internal();

  final Map<String, Map<Type, dynamic>> _data = {};

  void add<T>(String key, T value) {
    _data[key] = {T: value};
  }

  T? value<T>(String key) {
    return _data[key]?[T] as T?;
  }
}
