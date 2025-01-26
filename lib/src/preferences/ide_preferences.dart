// Componente Flutter para IdePreferences
import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdePreferencesWidget extends StatefulWidget {
  final IdePreferencesSettings idePreferences;

  IdePreferencesWidget({required this.idePreferences});

  @override
  _IdePreferencesWidgetState createState() => _IdePreferencesWidgetState();
}

class _IdePreferencesWidgetState extends State<IdePreferencesWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seleção de tema
            Text('Theme:'),
            DropdownButton<String>(
              value: widget.idePreferences.themeSelection.getCurrentTheme(),
              onChanged: (String? newTheme) {
                setState(() {
                  widget.idePreferences.themeSelection.selectTheme(newTheme ?? "Light");
                });
              },
              items: <String>["Light", "Dark", "Solarized"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            // Ajuste de zoom
            Text('Zoom Level:'),
            Slider(
              value: widget.idePreferences.zoomSettings.getZoomLevel(),
              min: 0.5,
              max: 3.0,
              divisions: 10,
              label: widget.idePreferences.zoomSettings.getZoomLevel().toString(),
              onChanged: (double newValue) {
                setState(() {
                  widget.idePreferences.zoomSettings.setZoom(newValue);
                });
              },
            ),
            SizedBox(height: 16),

            // Suporte a leitores de tela
            SwitchListTile(
              title: Text('Enable Screen Reader'),
              value: widget.idePreferences.accessibilitySettings.isScreenReaderEnabled(),
              onChanged: (bool value) {
                setState(() {
                  widget.idePreferences.accessibilitySettings.enableScreenReader(value);
                });
              },
            ),
            SizedBox(height: 16),

            // Uso de fonte personalizada
            SwitchListTile(
              title: Text('Use Custom Font'),
              value: widget.idePreferences.uiOptionsMenu.isUsingCustomFont(),
              onChanged: (bool value) {
                setState(() {
                  widget.idePreferences.uiOptionsMenu.useCustomFont(value);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}