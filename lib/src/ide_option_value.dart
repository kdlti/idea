/// Classe genérica que representa um item de opção com um rótulo e um valor associado.
///
/// Esta classe pode ser usada para representar um item de opção em um menu de seleção
/// ou em outras situações em que é necessário um rótulo descritivo para um determinado valor.
class IdeOptionValue<T> {
  /// O rótulo descritivo para este item de opção.
  final String label;

  /// O valor associado a este item de opção.
  final T value;

  /// Cria um novo [OptionItem] com o [label] especificado e o [value] associado.
  IdeOptionValue({required this.label, required this.value});

  /// Retorna uma representação em string deste [IdeOptionValue] com o nome da classe, o rótulo e o valor.
  @override
  String toString() {
    return 'Instance of OptionItem(name:$label, value:$value)';
  }
}
