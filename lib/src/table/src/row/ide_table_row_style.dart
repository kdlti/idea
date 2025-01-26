import 'package:flutter/material.dart';

class IdeTableRowStyle extends ThemeExtension<IdeTableRowStyle> {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final TextStyle? text;
  final CrossAxisAlignment? crossAxisAlignment;

  const IdeTableRowStyle({
    this.padding,
    this.margin,
    this.decoration,
    this.text,
    this.crossAxisAlignment,
  });

  @override
  ThemeExtension<IdeTableRowStyle> lerp(
      ThemeExtension<IdeTableRowStyle>? other, double t) {
    if (other is! IdeTableRowStyle) {
      return this;
    }

    return IdeTableRowStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      decoration: t < 0.5 ? decoration : other.decoration,
      text: TextStyle.lerp(text, other.text, t)!,
      crossAxisAlignment: t < 0.5 ? crossAxisAlignment : other.crossAxisAlignment,
    );
  }

  @override
  IdeTableRowStyle copyWith({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxDecoration? decoration,
    TextStyle? text,
    CrossAxisAlignment? crossAxisAlignment,
  }) {
    return IdeTableRowStyle(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      decoration: decoration ?? this.decoration,
      text: text ?? this.text,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
    );
  }

  @override
  String toString() =>
      'IdeTableRowStyle(padding: $padding, margin: $margin, decoration: $decoration, text: $text, crossAxisAlignment: $crossAxisAlignment)';
}
