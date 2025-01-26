import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:idea/src/translation/ide_messages.dart';

class IdeTranslation {
  final Map<String, Map<String, String>> _maplocales = {};
  List<String> locales = [];

  IdeTranslation(this.locales);

  Future<IdeMessages> get messages async {
    if (locales.isEmpty) {
      return IdeMessages();
    }

    try {
      for (final locale in locales) {
        String pathFileName = "assets/locales/$locale.json";
        final contentStr = await rootBundle.loadString(pathFileName);
        Map<String, dynamic> fileContent = json.decode(contentStr);
        _maplocales[locale] = fileContent.cast<String, String>();
      }
    } catch (e) {
      print("Error loading translations: $e");
    }

    return IdeMessages(_maplocales);
  }
}
