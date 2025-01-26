import 'package:flutter/material.dart';

class IdePanelFooterStyle extends ThemeExtension<IdePanelFooterStyle> {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;

  const IdePanelFooterStyle({
    this.padding,
    this.margin,
    this.decoration,
  });

  @override
  ThemeExtension<IdePanelFooterStyle> lerp(
      ThemeExtension<IdePanelFooterStyle>? other, double t) {
    if (other is! IdePanelFooterStyle) {
      return this;
    }

    return IdePanelFooterStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      decoration: t < 0.5 ? decoration : other.decoration,
    );
  }

  @override
  IdePanelFooterStyle copyWith({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxDecoration? decoration,
  }) {
    return IdePanelFooterStyle(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      decoration: decoration ?? this.decoration,
    );
  }

  @override
  String toString() =>
      'IdePanelFooterStyle(padding: $padding, margin: $margin, decoration: $decoration)';
}
