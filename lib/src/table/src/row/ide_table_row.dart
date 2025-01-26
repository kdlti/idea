import 'package:flutter/material.dart';

class IdeTableRow {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration decoration;
  final TextStyle style;
  final CrossAxisAlignment crossAxisAlignment;

  const IdeTableRow({
    this.padding,
    this.margin,
    required this.decoration,
    this.style = const TextStyle(color: Colors.red),
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });
}
