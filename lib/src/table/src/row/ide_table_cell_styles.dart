import 'package:flutter/material.dart';

class IdeTableCellStyle extends ThemeExtension<IdeTableCellStyle> {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final TextStyle? text;
  final CrossAxisAlignment? crossAxisAlignment;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const IdeTableCellStyle({
    this.padding,
    this.margin,
    this.decoration,
    this.text,
    this.crossAxisAlignment,
    this.maxLines,
    this.textAlign,
    this.overflow,
  });

  @override
  ThemeExtension<IdeTableCellStyle> lerp(ThemeExtension<IdeTableCellStyle>? other, double t) {
    if (other is! IdeTableCellStyle) {
      return this;
    }

    return IdeTableCellStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      decoration: t < 0.5 ? decoration : other.decoration,
      text: TextStyle.lerp(text, other.text, t)!,
      crossAxisAlignment: t < 0.5 ? crossAxisAlignment : other.crossAxisAlignment,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  @override
  IdeTableCellStyle copyWith({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxDecoration? decoration,
    TextStyle? text,
    CrossAxisAlignment? crossAxisAlignment,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
  }) {
    return IdeTableCellStyle(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      decoration: decoration ?? this.decoration,
      text: text ?? this.text,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      maxLines: maxLines ?? this.maxLines,
      textAlign: textAlign ?? this.textAlign,
      overflow: overflow ?? this.overflow,
    );
  }

  @override
  String toString() =>
      'IdeTableCellStyle(padding: $padding, margin: $margin, decoration: $decoration, text: $text, crossAxisAlignment: $crossAxisAlignment, '
      'maxLines: $maxLines, textAlign: $textAlign, overflow: $overflow)';
}
