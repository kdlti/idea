import 'package:flutter/material.dart';

class IdeTableExpandedRowStyle extends ThemeExtension<IdeTableExpandedRowStyle> {
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final TextStyle? text;
  final EdgeInsetsGeometry? padding;

  const IdeTableExpandedRowStyle({
    this.margin,
    this.decoration,
    this.text,
    this.padding,
  });

  @override
  ThemeExtension<IdeTableExpandedRowStyle> lerp(
      ThemeExtension<IdeTableExpandedRowStyle>? other, double t) {
    if (other is! IdeTableExpandedRowStyle) {
      return this;
    }

    return IdeTableExpandedRowStyle(
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      decoration: t < 0.5 ? decoration : other.decoration,
      text: TextStyle.lerp(text, other.text, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
    );
  }

  @override
  IdeTableExpandedRowStyle copyWith({
    EdgeInsetsGeometry? margin,
    BoxDecoration? decoration,
    TextStyle? text,
    EdgeInsetsGeometry? padding,
  }) {
    return IdeTableExpandedRowStyle(
      margin: margin ?? this.margin,
      decoration: decoration ?? this.decoration,
      text: text ?? this.text,
      padding: padding ?? this.padding,
    );
  }

  @override
  String toString() =>
      'IdeTableExpandedRowStyle(margin: $margin, decoration: $decoration, text: $text, padding: $padding)';
}
