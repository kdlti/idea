class IdeValidator {
  /// Função genérica para validar se um campo está vazio
  static String? isEmpty({String? value, required String errorMessage}) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }
}