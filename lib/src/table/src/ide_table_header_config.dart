import 'package:flutter/material.dart';

class IdeTableHeaderConfig {
  final TextStyle style;
  final TextStyle styleSelected;
  late Icon iconAscending;
  late Icon iconDescending;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Border? border;
  final Color color;
  final TextAlign textAlign;

  IdeTableHeaderConfig({
    this.style = const TextStyle(fontSize: 13, color: Colors.black87),
    this.styleSelected = const TextStyle(fontSize: 13, color: Colors.black),
    this.iconAscending = const Icon(Icons.arrow_upward, size: 15),
    this.iconDescending = const Icon(Icons.arrow_downward, size: 15),
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.color = Colors.black12,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    this.margin,
    this.textAlign = TextAlign.left,
    this.border,
  });
}
