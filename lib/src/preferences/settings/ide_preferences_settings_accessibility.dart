// Classe AccessibilitySettings
// Gerencia as opções de acessibilidade
class IdePreferencesSettingsAccessibility {
  bool _screenReaderEnabled = false;
  bool _colorDeficiencyAdjustment = false;

  // Ativa ou desativa o suporte a leitores de tela
  bool enableScreenReader(bool isEnabled) {
    _screenReaderEnabled = isEnabled;
    return _screenReaderEnabled;
  }

  // Retorna se o suporte a leitores de tela está ativado
  bool isScreenReaderEnabled() {
    return _screenReaderEnabled;
  }

  // Ativa ou desativa o ajuste para deficiência de cores
  bool adjustForColorDeficiency(bool isAdjusted) {
    _colorDeficiencyAdjustment = isAdjusted;
    return _colorDeficiencyAdjustment;
  }

  // Retorna se o ajuste para deficiência de cores está ativado
  bool isColorDeficiencyAdjusted() {
    return _colorDeficiencyAdjustment;
  }
}