/// Classe genérica que representa um item de opção com um rótulo e um valor associado.
///
/// Esta classe pode ser usada para representar um item de opção em um menu de seleção
/// ou em outras situações em que é necessário um rótulo descritivo para um determinado valor.
class IdeCheckboxListOption<T> {
  /// O identificador do item.
  final String id;

  /// O rótulo descritivo para este item de opção.
  final String label;

  /// O valor associado a este item de opção.
  T value;

  /// Cria um novo [OptionItem] com o [label] especificado e o [value] associado.
  IdeCheckboxListOption({required this.label, required this.value, required this.id});
}
