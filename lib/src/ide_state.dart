import 'package:idea/package.dart';

class IdeStateRegister {
  final String name;
  final dynamic state;

  IdeStateRegister({required this.name, required this.state});
}

class IdeState {
  Map<String, dynamic> _states = {};

  void add<T>(String name, T state) {
    _states[name] = state;
  }

  void disposeState<T>() {
    _states.remove(T.toString());
  }

  T? find<T>(String name) {
    return _states[name];
  }

  void redraw(String name, {bool force = false}) {
    dynamic state = _states[name];

    if (state != null && state.mounted) {
      if (Ide.mounted) {
        state.setState(() {});
      } else {
        print("IdeState.redraw($name) - Ide não está montado.");
      }
    } else if (!force) {
      ideLog.e(
        "redraw(String name) - Você está tentando utilizar um objeto do tipo state não registrado.",
        error: {"name": name},
        stackTrace: StackTrace.current,
      );
    }
  }

  void redrawAll() {
    _states.forEach((key, state) {
      state.setState(() {});
    });
  }

  void remove(String name) {
    _states.remove(_states[name]);
  }

  void removeAll() {
    _states.clear();
    _states = {};
  }

  void dispose() {
    removeAll();
  }

  Iterable<dynamic> get values {
    return _states.values;
  }

  bool get mounted {
    return _states.isNotEmpty && _states.containsKey("IdeModuleRender");
  }
}
