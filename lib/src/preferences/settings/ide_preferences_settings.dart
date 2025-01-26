// Classe principal IdePreferences
// Esta classe gerencia as configurações gerais da IDE, como tema, zoom, acessibilidade, fontes, etc.
import 'package:idea/package.dart';

class IdePreferencesSettings {
  ThemeSelection themeSelection;
  ZoomSettings zoomSettings;
  IdePreferencesSettingsAccessibility accessibilitySettings;
  UIOptionsMenu uiOptionsMenu;

  IdePreferencesSettings({
    required this.themeSelection,
    required this.zoomSettings,
    required this.accessibilitySettings,
    required this.uiOptionsMenu,
  });
}