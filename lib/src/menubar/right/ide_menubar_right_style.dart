import 'package:flutter/material.dart';

class IdeMenubarRightStyle extends ThemeExtension<IdeMenubarRightStyle> {
  final EdgeInsetsGeometry? buttonPadding;
  final EdgeInsetsGeometry? buttonMargin;
  final BoxDecoration? buttonDecoration;
  final BoxDecoration? buttonHoverDecoration;
  final BoxDecoration? buttonSelectedDecoration;
  final BoxDecoration? indicatorDecoration;
  final BoxDecoration? indicatorSelectedDecoration;
  final double? indicatorWidth;
  final EdgeInsetsGeometry? indicatorMargin;
  final double? iconSize;
  final Color? iconColor;
  final Color? iconSelectedColor;

  const IdeMenubarRightStyle({
    this.indicatorMargin,
    this.buttonDecoration,
    this.buttonHoverDecoration,
    this.buttonSelectedDecoration,
    this.indicatorDecoration,
    this.indicatorSelectedDecoration,
    this.buttonPadding,
    this.buttonMargin,
    this.indicatorWidth,
    this.iconSize,
    this.iconColor,
    this.iconSelectedColor,
  });

  @override
  ThemeExtension<IdeMenubarRightStyle> lerp(
      ThemeExtension<IdeMenubarRightStyle>? other, double t) {
    if (other is! IdeMenubarRightStyle) {
      return this;
    }

    return IdeMenubarRightStyle(
      indicatorMargin:
      EdgeInsetsGeometry.lerp(indicatorMargin, other.indicatorMargin, t),
      buttonDecoration:
      BoxDecoration.lerp(buttonDecoration, other.buttonDecoration, t),
      buttonHoverDecoration: BoxDecoration.lerp(
          buttonHoverDecoration, other.buttonHoverDecoration, t),
      buttonSelectedDecoration: BoxDecoration.lerp(
          buttonSelectedDecoration, other.buttonSelectedDecoration, t),
      indicatorDecoration:
      BoxDecoration.lerp(indicatorDecoration, other.indicatorDecoration, t),
      indicatorSelectedDecoration: BoxDecoration.lerp(
          indicatorSelectedDecoration, other.indicatorSelectedDecoration, t),
      buttonPadding: EdgeInsetsGeometry.lerp(buttonPadding, other.buttonPadding, t),
      buttonMargin: EdgeInsetsGeometry.lerp(buttonMargin, other.buttonMargin, t),
      indicatorWidth: indicatorWidth! + (other.indicatorWidth! - indicatorWidth!) * t,
      iconSize: iconSize! + (other.iconSize! - iconSize!) * t,
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      iconSelectedColor: Color.lerp(iconSelectedColor, other.iconSelectedColor, t),
    );
  }

  @override
  IdeMenubarRightStyle copyWith({
    EdgeInsetsGeometry? indicatorMargin,
    BoxDecoration? buttonDecoration,
    BoxDecoration? buttonHoverDecoration,
    BoxDecoration? buttonSelectedDecoration,
    BoxDecoration? indicatorDecoration,
    BoxDecoration? indicatorSelectedDecoration,
    EdgeInsetsGeometry? buttonPadding,
    EdgeInsetsGeometry? buttonMargin,
    double? indicatorWidth,
    double? iconSize,
    Color? iconColor,
    Color? iconSelectedColor,
  }) {
    return IdeMenubarRightStyle(
      indicatorMargin: indicatorMargin ?? this.indicatorMargin,
      buttonDecoration: buttonDecoration ?? this.buttonDecoration,
      buttonHoverDecoration:
      buttonHoverDecoration ?? this.buttonHoverDecoration,
      buttonSelectedDecoration:
      buttonSelectedDecoration ?? this.buttonSelectedDecoration,
      indicatorDecoration:
      indicatorDecoration ?? this.indicatorDecoration,
      indicatorSelectedDecoration:
      indicatorSelectedDecoration ?? this.indicatorSelectedDecoration,
      buttonPadding: buttonPadding ?? this.buttonPadding,
      buttonMargin: buttonMargin ?? this.buttonMargin,
      indicatorWidth: indicatorWidth ?? this.indicatorWidth,
      iconSize: iconSize ?? this.iconSize,
      iconColor: iconColor ?? this.iconColor,
      iconSelectedColor: iconSelectedColor ?? this.iconSelectedColor,
    );
  }
}
