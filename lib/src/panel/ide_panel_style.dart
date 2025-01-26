import 'package:flutter/material.dart';

class IdePanelStyle extends ThemeExtension<IdePanelStyle> {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;

  const IdePanelStyle({
    this.padding,
    this.margin,
    this.decoration,
  });

  @override
  ThemeExtension<IdePanelStyle> lerp(
      ThemeExtension<IdePanelStyle>? other, double t) {
    if (other is! IdePanelStyle) {
      return this;
    }

    return IdePanelStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      decoration: t < 0.5 ? decoration : other.decoration,
    );
  }

  @override
  IdePanelStyle copyWith({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxDecoration? decoration,
  }) {
    return IdePanelStyle(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      decoration: decoration ?? this.decoration,
    );
  }

  @override
  String toString() =>
      'IdePanelStyle(padding: $padding, margin: $margin, decoration: $decoration)';
}
