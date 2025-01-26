import 'package:flutter/material.dart';

class IdeIconButtonDecoration {
  final Color color;
  final Color colorHover;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double borderRadius;
  final double elevation;
  final double iconSize;
  final Color iconColor;
  final Color iconColorHover;

  const IdeIconButtonDecoration({
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.elevation = 0,
    this.iconSize = 18,
    this.iconColor = Colors.black54,
    this.iconColorHover = Colors.black87,
    this.color = Colors.transparent,
    this.colorHover = const Color(0xFFededed),
    this.borderRadius = 4,
  });
}
