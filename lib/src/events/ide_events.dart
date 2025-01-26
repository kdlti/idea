import 'package:flutter/services.dart';
import 'package:idea/src/menu/ide_menu_event.dart';

class IdeEvents {
  static String activeShortcutEvent = '';
  static Map<String, IdeMenuEvent> shortcutEvents = {};

  static void handleKeyEvent(RawKeyEvent event) async {
    String pressedKey = '';
    String logicalKey = '';

    /*if(event.isControlPressed && event.isKeyPressed(LogicalKeyboardKey.keyU)){

    }*/

    if (event.isControlPressed ||
        event.isAltPressed ||
        event.isShiftPressed ||
        event.isKeyPressed(LogicalKeyboardKey.insert) ||
        event.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
        event.isKeyPressed(LogicalKeyboardKey.arrowRight) ||
        event.isKeyPressed(LogicalKeyboardKey.arrowUp) ||
        event.isKeyPressed(LogicalKeyboardKey.arrowDown) ||
        event.isKeyPressed(LogicalKeyboardKey.delete) ||
        event.isKeyPressed(LogicalKeyboardKey.home) ||
        event.isKeyPressed(LogicalKeyboardKey.end) ||
        event.isKeyPressed(LogicalKeyboardKey.backspace) ||
        event.isKeyPressed(LogicalKeyboardKey.pageDown) ||
        event.isKeyPressed(LogicalKeyboardKey.pageUp)) {
      if (event.isControlPressed && event.isAltPressed && event.isShiftPressed) {
        pressedKey += 'Ctrl+Alt+Shift+';
      } else if (event.isControlPressed && event.isAltPressed) {
        pressedKey += 'Ctrl+Alt+';
      } else if (event.isControlPressed && event.isShiftPressed) {
        pressedKey += 'Ctrl+Shift+';
      } else if (event.isAltPressed && event.isShiftPressed) {
        pressedKey += 'Alt+Shift+';
      } else if (event.isControlPressed) {
        pressedKey += 'Ctrl+';
      } else if (event.isAltPressed) {
        pressedKey += 'Alt+';
      } else if (event.isShiftPressed) {
        pressedKey += 'Shift+';
      }

      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        logicalKey += 'Esquerda';
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        logicalKey += 'Direita';
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        logicalKey += 'Acima';
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        logicalKey += 'Abaixo';
      } else if (event.logicalKey == LogicalKeyboardKey.home) {
        logicalKey += 'Home';
      } else if (event.logicalKey == LogicalKeyboardKey.end) {
        logicalKey += 'End';
      } else if (event.logicalKey == LogicalKeyboardKey.delete) {
        logicalKey += 'Delete';
      } else if (event.logicalKey == LogicalKeyboardKey.insert) {
        logicalKey += 'Insert';
      } else if (event.logicalKey == LogicalKeyboardKey.pageDown) {
        logicalKey += 'PgDn';
      } else if (event.logicalKey == LogicalKeyboardKey.pageUp) {
        logicalKey += 'PgUp';
      } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
        logicalKey += 'Backspace';
      } else {
        logicalKey += event.logicalKey.keyLabel.toUpperCase();
      }

      String eventKey = '';
      if (logicalKey != '') {
        if (pressedKey != '') {
          eventKey = pressedKey;
        }
        eventKey += logicalKey;
      }

      Future<String> dispatch(String eventKey) async {
        IdeMenuEvent? menu = shortcutEvents[eventKey];
        if (menu != null) {
          menu.onEvent(menu.response());
        }
        return eventKey;
      }

      if (eventKey != '' && activeShortcutEvent != eventKey) {
        activeShortcutEvent = await dispatch(eventKey);
        await Future.delayed(const Duration(seconds: 1));
        activeShortcutEvent = '';
      }
    }
  }

  static addShortcut({String shortcut = '', dynamic menuEvent}) {
    if (shortcut.isNotEmpty && menuEvent != null) {
      shortcutEvents[shortcut] = menuEvent;
    }
  }
}
