import 'package:flutter/material.dart';

class IdeTableRowHoverStyle extends ThemeExtension<IdeTableRowHoverStyle> {
  final BoxDecoration? decoration;
  final TextStyle? text;

  const IdeTableRowHoverStyle({
    this.decoration,
    this.text,
  });

  @override
  ThemeExtension<IdeTableRowHoverStyle> lerp(
      ThemeExtension<IdeTableRowHoverStyle>? other, double t) {
    if (other is! IdeTableRowHoverStyle) {
      return this;
    }

    return IdeTableRowHoverStyle(
      decoration: t < 0.5 ? decoration : other.decoration,
      text: TextStyle.lerp(text, other.text, t)!,
    );
  }

  @override
  IdeTableRowHoverStyle copyWith({
    BoxDecoration? decoration,
    TextStyle? text,
  }) {
    return IdeTableRowHoverStyle(
      decoration: decoration ?? this.decoration,
      text: text ?? this.text,
    );
  }

  @override
  String toString() =>
      'IdeTableRowHoverStyle(decoration: $decoration, text: $text)';
}
