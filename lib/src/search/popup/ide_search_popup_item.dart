import 'package:flutter/material.dart';

class IdeSearchPopupItem {
  final String name;
  final String label;
  final IconData? icon;
  bool selected;

  IdeSearchPopupItem({
    required this.name,
    required this.label,
    this.icon,
    this.selected = false,
  });

  @override
  toString() {
    return 'IdeSearchPopupItem(name: $name, label: $label, icon: $icon, selected: $selected)';
  }
}
