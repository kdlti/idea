import 'package:flutter/material.dart';

class IdeMenubarBottomStyle extends ThemeExtension<IdeMenubarBottomStyle> {
  final EdgeInsetsGeometry? indicatorMargin;
  final TextStyle? text;
  final TextStyle? textHover;
  final TextStyle? textSelected;
  final BoxDecoration? buttonDecoration;
  final BoxDecoration? buttonHoverDecoration;
  final BoxDecoration? buttonSelectedDecoration;
  final BoxDecoration? indicatorDecoration;
  final BoxDecoration? indicatorHoverDecoration;
  final BoxDecoration? indicatorSelectedDecoration;
  final Color? iconCloseColor;
  final Color? iconCloseHoverColor;
  final double? iconCloseSize;
  final double? buttonHorizontalGap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? buttonPadding;
  final EdgeInsetsGeometry? buttonMargin;
  final double? indicatorHeight;
  final double? iconSize;
  final Color? iconColor; // New property
  final Color? iconHoverColor; // New property
  final Color? iconSelectedColor; // New property
  final bool showTooltip;

  const IdeMenubarBottomStyle({
    this.indicatorMargin,
    this.text,
    this.textHover,
    this.textSelected,
    this.buttonDecoration,
    this.buttonHoverDecoration,
    this.buttonSelectedDecoration,
    this.indicatorDecoration,
    this.indicatorHoverDecoration,
    this.indicatorSelectedDecoration,
    this.iconCloseColor,
    this.iconCloseHoverColor,
    this.iconCloseSize = 13,
    this.buttonHorizontalGap,
    this.margin,
    this.buttonPadding,
    this.buttonMargin,
    this.indicatorHeight,
    this.iconSize,
    this.iconColor, // Initialize the new property in the constructor
    this.iconHoverColor, // Initialize the new property in the constructor
    this.iconSelectedColor, // Initialize the new property in the constructor
    this.showTooltip = false,
  });

  @override
  ThemeExtension<IdeMenubarBottomStyle> lerp(
      ThemeExtension<IdeMenubarBottomStyle>? other, double t) {
    if (other is! IdeMenubarBottomStyle) {
      return this;
    }

    return IdeMenubarBottomStyle(
      indicatorMargin:
      EdgeInsetsGeometry.lerp(indicatorMargin, other.indicatorMargin, t),
      text: TextStyle.lerp(text, other.text, t),
      textHover: TextStyle.lerp(textHover, other.textHover, t),
      textSelected: TextStyle.lerp(textSelected, other.textSelected, t),
      buttonDecoration:
      BoxDecoration.lerp(buttonDecoration, other.buttonDecoration, t),
      buttonHoverDecoration: BoxDecoration.lerp(
          buttonHoverDecoration, other.buttonHoverDecoration, t),
      buttonSelectedDecoration: BoxDecoration.lerp(
          buttonSelectedDecoration, other.buttonSelectedDecoration, t),
      indicatorDecoration:
      BoxDecoration.lerp(indicatorDecoration, other.indicatorDecoration, t),
      indicatorHoverDecoration: BoxDecoration.lerp(
          indicatorHoverDecoration, other.indicatorHoverDecoration, t),
      indicatorSelectedDecoration: BoxDecoration.lerp(
          indicatorSelectedDecoration, other.indicatorSelectedDecoration, t),
      iconCloseColor: Color.lerp(iconCloseColor, other.iconCloseColor, t),
      iconCloseHoverColor:
      Color.lerp(iconCloseHoverColor, other.iconCloseHoverColor, t),
      iconCloseSize:
      iconCloseSize! + (other.iconCloseSize! - iconCloseSize!) * t,
      buttonHorizontalGap:
      buttonHorizontalGap! + (other.buttonHorizontalGap! - buttonHorizontalGap!) * t,
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      buttonPadding: EdgeInsetsGeometry.lerp(buttonPadding, other.buttonPadding, t),
      buttonMargin: EdgeInsetsGeometry.lerp(buttonMargin, other.buttonMargin, t),
      indicatorHeight: indicatorHeight! + (other.indicatorHeight! - indicatorHeight!) * t,
      iconSize: iconSize! + (other.iconSize! - iconSize!) * t,
      iconColor: Color.lerp(iconColor, other.iconColor, t), // Lerp for the new property
      iconHoverColor: Color.lerp(iconHoverColor, other.iconHoverColor, t), // Lerp for the new property
      iconSelectedColor: Color.lerp(iconSelectedColor, other.iconSelectedColor, t), // Lerp for the new property
    );
  }

  @override
  IdeMenubarBottomStyle copyWith({
    EdgeInsetsGeometry? padding,
    BoxDecoration? decoration,
    EdgeInsetsGeometry? indicatorMargin,
    TextStyle? text,
    TextStyle? textHover,
    TextStyle? textSelected,
    BoxDecoration? buttonDecoration,
    BoxDecoration? buttonHoverDecoration,
    BoxDecoration? buttonSelectedDecoration,
    BoxDecoration? indicatorDecoration,
    BoxDecoration? indicatorHoverDecoration,
    BoxDecoration? indicatorSelectedDecoration,
    Color? iconCloseColor,
    Color? iconCloseHoverColor,
    double? iconCloseSize,
    double? buttonHorizontalGap,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? buttonPadding,
    EdgeInsetsGeometry? buttonMargin,
    double? indicatorHeight,
    double? iconSize,
    Color? iconColor, // Add the new property to the copyWith method
    Color? iconHoverColor, // Add the new property to the copyWith method
    Color? iconSelectedColor, // Add the new property to the copyWith method
  }) {
    return IdeMenubarBottomStyle(
      indicatorMargin: indicatorMargin ?? this.indicatorMargin,
      text: text ?? this.text,
      textHover: textHover ?? this.textHover,
      textSelected: textSelected ?? this.textSelected,
      buttonDecoration: buttonDecoration ?? this.buttonDecoration,
      buttonHoverDecoration:
      buttonHoverDecoration ?? this.buttonHoverDecoration,
      buttonSelectedDecoration:
      buttonSelectedDecoration ?? this.buttonSelectedDecoration,
      indicatorDecoration:
      indicatorDecoration ?? this.indicatorDecoration,
      indicatorHoverDecoration:
      indicatorHoverDecoration ?? this.indicatorHoverDecoration,
      indicatorSelectedDecoration:
      indicatorSelectedDecoration ?? this.indicatorSelectedDecoration,
      iconCloseColor: iconCloseColor ?? this.iconCloseColor,
      iconCloseHoverColor: iconCloseHoverColor ?? this.iconCloseHoverColor,
      iconCloseSize: iconCloseSize ?? this.iconCloseSize,
      buttonHorizontalGap: buttonHorizontalGap ?? this.buttonHorizontalGap,
      margin: margin ?? this.margin,
      buttonPadding: buttonPadding ?? this.buttonPadding,
      buttonMargin: buttonMargin ?? this.buttonMargin,
      indicatorHeight: indicatorHeight ?? this.indicatorHeight,
      iconSize: iconSize ?? this.iconSize,
      iconColor: iconColor ?? this.iconColor, // Assign the new property when creating a new instance
      iconHoverColor: iconHoverColor ?? this.iconHoverColor, // Assign the new property when creating a new instance
      iconSelectedColor: iconSelectedColor ?? this.iconSelectedColor, // Assign the new property when creating a new instance
    );
  }
}
