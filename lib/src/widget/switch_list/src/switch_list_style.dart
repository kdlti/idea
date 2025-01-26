import 'package:flutter/material.dart';

class IdeSwitchListStyle extends ThemeExtension<IdeSwitchListStyle> {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final TextStyle? title; // Added property
  final TextStyle? subTitle; // Added property

  const IdeSwitchListStyle({
    this.padding,
    this.margin,
    this.decoration,
    this.title,
    this.subTitle,
  });

  @override
  ThemeExtension<IdeSwitchListStyle> lerp(
      ThemeExtension<IdeSwitchListStyle>? other, double t) {
    if (other is! IdeSwitchListStyle) {
      return this;
    }

    return IdeSwitchListStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      decoration: t < 0.5 ? decoration : other.decoration,
      title: TextStyle.lerp(title, other.title, t), // Added property
      subTitle: TextStyle.lerp(subTitle, other.subTitle, t), // Added property
    );
  }

  @override
  IdeSwitchListStyle copyWith({
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxDecoration? decoration,
    TextStyle? title, // Added property
    TextStyle? subTitle, // Added property
  }) {
    return IdeSwitchListStyle(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      decoration: decoration ?? this.decoration,
      title: title ?? this.title, // Added property
      subTitle: subTitle ?? this.subTitle, // Added property
    );
  }

  @override
  String toString() =>
      'IdeListSwitchStyle(padding: $padding, margin: $margin, decoration: $decoration, title: $title, subTitle: $subTitle)'; // Updated toString method
}
