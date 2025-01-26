import 'package:flutter/material.dart';

class IdeTableRowCheckedStyle extends ThemeExtension<IdeTableRowCheckedStyle> {
  final BoxDecoration? decoration;
  final TextStyle? text;

  const IdeTableRowCheckedStyle({
    this.decoration,
    this.text = const TextStyle(color: Colors.red),
  });

  @override
  ThemeExtension<IdeTableRowCheckedStyle> lerp(
      ThemeExtension<IdeTableRowCheckedStyle>? other, double t) {
    if (other is! IdeTableRowCheckedStyle) {
      return this;
    }

    return IdeTableRowCheckedStyle(
      decoration: t < 0.5 ? decoration : other.decoration,
      text: TextStyle.lerp(text, other.text, t)!,
    );
  }

  @override
  IdeTableRowCheckedStyle copyWith({
    BoxDecoration? decoration,
    TextStyle? text,
  }) {
    return IdeTableRowCheckedStyle(
      decoration: decoration ?? this.decoration,
      text: text ?? this.text,
    );
  }

  @override
  String toString() =>
      'IdeTableRowCheckedStyle(decoration: $decoration, text: $text)';
}
