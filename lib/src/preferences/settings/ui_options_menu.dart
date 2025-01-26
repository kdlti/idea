// Classe UIOptionsMenu
// Gerencia as opções da interface de usuário
class UIOptionsMenu {
  bool _usingCustomFont = false;

  // Ativa ou desativa o uso de fontes personalizadas
  bool useCustomFont(bool isCustom) {
    _usingCustomFont = isCustom;
    return _usingCustomFont;
  }

  // Retorna se a fonte personalizada está ativada
  bool isUsingCustomFont() {
    return _usingCustomFont;
  }
}