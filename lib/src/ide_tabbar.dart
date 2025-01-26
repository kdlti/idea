import 'package:flutter/material.dart';

class IdeTabbar {
  final String label;
  final String? tooltip;
  final IconData icon;
  final bool alowClose;

  const IdeTabbar({
    required this.label,
    required this.icon,
    this.tooltip,
    this.alowClose = true,
  });
}
