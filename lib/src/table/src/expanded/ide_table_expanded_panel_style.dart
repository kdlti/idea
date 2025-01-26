import 'package:flutter/material.dart';

class IdeTableExpandedPanelStyle extends ThemeExtension<IdeTableExpandedPanelStyle> {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;

  const IdeTableExpandedPanelStyle({
    this.padding,
    this.margin,
    this.decoration,
  });

  @override
  ThemeExtension<IdeTableExpandedPanelStyle> lerp(
      ThemeExtension<IdeTableExpandedPanelStyle>? other, double t) {
    if (other is! IdeTableExpandedPanelStyle) {
      return this;
    }

    return IdeTableExpandedPanelStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      decoration: t < 0.5 ? decoration : other.decoration,
    );
  }

  @override
  IdeTableExpandedPanelStyle copyWith({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxDecoration? decoration,
  }) {
    return IdeTableExpandedPanelStyle(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      decoration: decoration ?? this.decoration,
    );
  }

  @override
  String toString() =>
      'IdeTableExpandedPanelStyle(padding: $padding, margin: $margin, decoration: $decoration)';
}
