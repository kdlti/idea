import 'package:flutter/material.dart';
import 'package:idea/src/events/ide_events.dart';
import 'package:idea/src/menu/ide_menu_abastract.dart';
import 'package:idea/src/menu/ide_menu_event.dart';
import 'package:idea/src/menu/ide_menu_response.dart';

// ignore: must_be_immutable
class IdeSubmenuItem extends IdeMenuAbastract {
  final bool divider;
  final bool enabled;
  final IconData? icon;
  final String title;
  final String shortcut;
  final ValueChanged<IdeMenuResponse> onEvent;

  String uid = '';
  IdeMenuEvent? menuEvent;
  bool isChecked = false;

  /// Status indica se o componente está habilitado
  bool isEnabled = true;

  IdeSubmenuItem({
    super.key,
    this.divider = false,
    this.enabled = true,
    this.icon,
    required this.onEvent,
    required this.title,
    this.shortcut = '',
  }) {
    isEnabled = enabled;
    //uid = ApiSecurity.uidSha1(title);
    uid = title;

    menuEvent = IdeMenuEvent(
      onEvent: onEvent,
      title: title,
      uid: uid,
    );

    if (shortcut.isNotEmpty) {
      IdeEvents.addShortcut(
        shortcut: shortcut,
        menuEvent: menuEvent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
