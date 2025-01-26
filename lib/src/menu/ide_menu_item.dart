import 'package:flutter/material.dart';
import 'package:idea/src/events/ide_events.dart';
import 'package:idea/src/menu/ide_menu_abastract.dart';
import 'package:idea/src/menu/ide_menu_event.dart';
import 'package:idea/src/menu/ide_menu_response.dart';

// ignore: must_be_immutable
class IdeMenuItem extends IdeMenuAbastract {
  final List<IdeMenuAbastract>? children;
  final bool divider;
  final IconData? icon;
  final String shortcut;
  final String title;
  final double width;
  final ValueChanged<IdeMenuResponse>? onEvent;

  String uid = '';
  bool enabled;
  bool isChecked = false;
  IdeMenuEvent? menuEvent;

  IdeMenuItem({
    super.key,
    this.children,
    this.divider = false,
    this.enabled = true,
    this.icon,
    required this.title,
    this.shortcut = '',
    this.width = 250,
    this.onEvent,
  }) {
    //uid = ApiSecurity.uidSha1(title);
    uid = title;

    if (onEvent != null && enabled) {
      menuEvent = IdeMenuEvent(
        onEvent: onEvent!,
        title: title,
        uid: uid,
      );

      IdeEvents.addShortcut(
        shortcut: shortcut,
        menuEvent: menuEvent,
      );
    } else {
      enabled = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
