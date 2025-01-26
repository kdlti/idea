import 'package:flutter/material.dart';

class IdePanelRightButtonMenu {
  final String tooltip;
  final IconData icon;
  final String? iconSvg;
  final VoidCallback? onPressed;
  final bool divider;

  const IdePanelRightButtonMenu({
    required this.tooltip,
    required this.icon,
    this.onPressed,
    this.iconSvg,
    this.divider = false,
  });
}
