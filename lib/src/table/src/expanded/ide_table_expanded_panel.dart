import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdeTableExpandedPanel {
  final Icon icon;
  final bool checkboxShow;
  final bool showButtonClose;
  final bool showRowWhenExpanded;
  final Widget Function(Map<String, dynamic> value) onExpanded;
  final IdeTableExpandedPanelStyle? style;
  final IdeTableExpandedRowStyle? rowStyle;
  final bool visible;
  final List<bool> expandedList;

  const IdeTableExpandedPanel({
    this.icon = const Icon(Icons.keyboard_arrow_up, size: 22),
    this.checkboxShow = true,
    this.showButtonClose = true,
    this.showRowWhenExpanded = true,
    required this.onExpanded,
    required this.expandedList,
    this.style,
    this.rowStyle,
    this.visible = true,
  });
}
