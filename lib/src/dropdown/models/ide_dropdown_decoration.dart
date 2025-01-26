part of '../ide_dropdown.dart';

class IdeDropdownDecoration {
  /// [IdeDropdown] field color (closed state).
  ///
  /// Default to [Colors.white].
  final Color? closedFillColor;

  /// [IdeDropdown] overlay color (opened/expanded state).
  ///
  /// Default to [Colors.white].
  final Color? expandedFillColor;

  /// [IdeDropdown] box shadow (closed state).
  final List<BoxShadow>? closedShadow;

  /// [IdeDropdown] box shadow (opened/expanded state).
  final List<BoxShadow>? expandedShadow;

  /// Suffix icon for closed state of [IdeDropdown].
  final Widget? closedSuffixIcon;

  /// Suffix icon for opened/expanded state of [IdeDropdown].
  final Widget? expandedSuffixIcon;

  /// Border for closed state of [IdeDropdown].
  final BoxBorder? closedBorder;

  /// Border radius for closed state of [IdeDropdown].
  final BorderRadius? closedBorderRadius;

  /// Error border for closed state of [IdeDropdown].
  final BoxBorder? closedErrorBorder;

  /// Error border radius for closed state of [IdeDropdown].
  final BorderRadius? closedErrorBorderRadius;

  /// Border for opened/expanded state of [IdeDropdown].
  final BoxBorder? expandedBorder;

  /// Border radius for opened/expanded state of [IdeDropdown].
  final BorderRadius? expandedBorderRadius;

  /// The style to use for the [IdeDropdown] header hint.
  final TextStyle? hintStyle;

  /// The style to use for the [IdeDropdown] header text.
  final TextStyle? headerStyle;

  /// The style to use for the [IdeDropdown] no result found area.
  final TextStyle? noResultFoundStyle;

  /// The style to use for the string returning from [validator].
  final TextStyle? errorStyle;

  /// The style to use for the [IdeDropdown] list item text.
  final TextStyle? listItemStyle;

  /// [IdeDropdown] scrollbar decoration (opened/expanded state).
  final ScrollbarThemeData? overlayScrollbarDecoration;

  /// [IdeDropdown] search field decoration.
  final SearchFieldDecoration? searchFieldDecoration;

  /// [IdeDropdown] list item decoration.
  final ListItemDecoration? listItemDecoration;

  const IdeDropdownDecoration({
    this.closedFillColor,
    this.expandedFillColor,
    this.closedShadow,
    this.expandedShadow,
    this.closedSuffixIcon,
    this.expandedSuffixIcon,
    this.closedBorder,
    this.closedBorderRadius,
    this.closedErrorBorder,
    this.closedErrorBorderRadius,
    this.expandedBorder,
    this.expandedBorderRadius,
    this.hintStyle,
    this.headerStyle,
    this.noResultFoundStyle,
    this.errorStyle,
    this.listItemStyle,
    this.overlayScrollbarDecoration,
    this.searchFieldDecoration,
    this.listItemDecoration,
  });

  static const Color _defaultFillColor = Colors.white;
}
