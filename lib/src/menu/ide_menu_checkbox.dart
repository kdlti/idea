import 'package:flutter/material.dart';
import 'package:idea/src/events/ide_events.dart';
import 'package:idea/src/menu/ide_menu_abastract.dart';
import 'package:idea/src/menu/ide_menu_event.dart';
import 'package:idea/src/menu/ide_menu_response.dart';

// ignore: must_be_immutable
class IdeMenuCheckbox extends IdeMenuAbastract {
  final bool divider;
  final bool enabled;
  final String shortcut;
  final String title;
  final double width;

  final ValueChanged<IdeMenuResponse> onEvent;
  bool isChecked = false;
  IconData icon = Icons.check;
  List<IdeMenuAbastract>? children;
  IdeMenuEvent? menuEvent;
  String uid = '';

  /// Status indica se o componente está habilitado
  bool isEnabled = true;

  IdeMenuCheckbox({
    super.key,
    required this.title,
    required this.isChecked,
    this.divider = false,
    this.enabled = true,
    this.shortcut = '',
    this.width = 250,
    required this.onEvent,
  }) {
    isEnabled = enabled;
    //uid = ApiSecurity.uidSha1(title);
    uid = title;

    menuEvent = IdeMenuEvent(
      onEvent: onEvent,
      title: title,
      uid: uid,
      isChecked: isChecked,
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
