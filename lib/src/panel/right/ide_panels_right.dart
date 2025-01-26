import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdePanelsRight {
  List<IdePanelRight> children;
  final String? initId;

  final bool? overlay;
  final double? width;
  final IdePushedByVertical pushedByVertical;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final Clip clipBehavior;
  final ValueChanged<String>? onShow;

  IdePanelsRight({
    required this.children,
    this.initId,
    this.overlay = false,
    this.width = 300,
    this.padding,
    this.margin,
    this.decoration,
    this.clipBehavior = Clip.antiAlias,
    this.onShow,
    this.pushedByVertical = const IdePushedByVertical(
      menubar: true,
      appbar: true,
      toolbar: true,
      menubarTop: true,
      statusbar: true,
      menubarBottom: true,
      panelBottom: true,
    ),
  });
}
