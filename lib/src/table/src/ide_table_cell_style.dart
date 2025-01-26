import 'package:flutter/material.dart';

class IdeTablecellStyle extends ThemeExtension<IdeTablecellStyle> {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final TextStyle? text;
  final CrossAxisAlignment? crossAxisAlignment;

  const IdeTablecellStyle({
    this.padding,
    this.margin,
    this.decoration,
    this.text,
    this.crossAxisAlignment,
  });

  @override
  ThemeExtension<IdeTablecellStyle> lerp(
      ThemeExtension<IdeTablecellStyle>? other, double t) {
    if (other is! IdeTablecellStyle) {
      return this;
    }

    return IdeTablecellStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      decoration: t < 0.5 ? decoration : other.decoration,
      text: TextStyle.lerp(text, other.text, t)!,
      crossAxisAlignment: t < 0.5 ? crossAxisAlignment : other.crossAxisAlignment,
    );
  }

  @override
  IdeTablecellStyle copyWith({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxDecoration? decoration,
    TextStyle? text,
    CrossAxisAlignment? crossAxisAlignment,
  }) {
    return IdeTablecellStyle(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      decoration: decoration ?? this.decoration,
      text: text ?? this.text,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
    );
  }

  @override
  String toString() =>
      'IdeTablecellStyle(padding: $padding, margin: $margin, decoration: $decoration, text: $text, crossAxisAlignment: $crossAxisAlignment)';
}
