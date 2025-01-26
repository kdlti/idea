import 'package:flutter/material.dart';

class IdeTableRowSelectedStyle extends ThemeExtension<IdeTableRowSelectedStyle> {
  final BoxDecoration? decoration;
  final TextStyle? text;

  const IdeTableRowSelectedStyle({
    this.decoration,
    this.text = const TextStyle(color: Colors.red),
  });

  @override
  ThemeExtension<IdeTableRowSelectedStyle> lerp(
      ThemeExtension<IdeTableRowSelectedStyle>? other, double t) {
    if (other is! IdeTableRowSelectedStyle) {
      return this;
    }

    return IdeTableRowSelectedStyle(
      decoration: t < 0.5 ? decoration : other.decoration,
      text: TextStyle.lerp(text, other.text, t)!,
    );
  }

  @override
  IdeTableRowSelectedStyle copyWith({
    BoxDecoration? decoration,
    TextStyle? text,
  }) {
    return IdeTableRowSelectedStyle(
      decoration: decoration ?? this.decoration,
      text: text ?? this.text,
    );
  }

  @override
  String toString() =>
      'IdeTableRowSelectedStyle(decoration: $decoration, text: $text)';
}
