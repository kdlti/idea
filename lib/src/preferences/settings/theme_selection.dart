// Classe ThemeSelection
// Gerencia a seleção de temas da interface da IDE
class ThemeSelection {
  String _currentTheme = "Light";

  // Seleciona o tema da IDE
  String selectTheme(String theme) {
    _currentTheme = theme;
    return _currentTheme;
  }

  // Retorna o tema atual
  String getCurrentTheme() {
    return _currentTheme;
  }
}