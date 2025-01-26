import 'package:flutter/material.dart';

class IdeContextMenuButton {
  final String label;
  final String? shortcutLabel;
  final VoidCallback? onPressed;
  final Icon? icon;
  final Widget? iconHover;

  IdeContextMenuButton(this.label, {required this.onPressed, this.shortcutLabel, this.icon, this.iconHover});
}