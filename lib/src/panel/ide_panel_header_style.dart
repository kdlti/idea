import 'package:flutter/material.dart';

class IdePanelHeaderStyle extends ThemeExtension<IdePanelHeaderStyle> {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;

  const IdePanelHeaderStyle({
    this.padding,
    this.margin,
    this.decoration,
  });

  @override
  ThemeExtension<IdePanelHeaderStyle> lerp(
      ThemeExtension<IdePanelHeaderStyle>? other, double t) {
    if (other is! IdePanelHeaderStyle) {
      return this;
    }

    return IdePanelHeaderStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      decoration: t < 0.5 ? decoration : other.decoration,
    );
  }

  @override
  IdePanelHeaderStyle copyWith({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxDecoration? decoration,
  }) {
    return IdePanelHeaderStyle(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      decoration: decoration ?? this.decoration,
    );
  }

  @override
  String toString() =>
      'IdePanelHeaderStyle(padding: $padding, margin: $margin, decoration: $decoration)';
}
