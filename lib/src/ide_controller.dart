import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';

abstract class IdeController extends DisposableInterface with ListenableMixin, ListNotifierMixin {
  /// Rebuilds `GetBuilder` each time you call `update()`;
  /// Can take a List of [ids], that will only update the matching
  /// `GetBuilder( id: )`,
  /// [ids] can be reused among `GetBuilders` like group tags.
  /// The update will only notify the Widgets, if [condition] is true.
  void update([List<Object>? ids, bool condition = true]) {
    if (!condition) {
      return;
    }
    if (ids == null) {
      refresh();
    } else {
      for (final id in ids) {
        refreshGroup(id);
      }
    }
  }

  /// Indica se estamos em um fluxo de carregamento
  final RxBool _isLoading = false.obs;

  /// Helper para ativar/desativar loading
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  bool get isLoading => _isLoading.value;

  /// Armazena mensagem de erro (nula se não houver erro)
  final RxnString error = RxnString();

  /// Helper para definir (ou limpar) erro
  void setError(String? message) {
    error.value = message;
    update();
  }
}
