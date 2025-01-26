import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdePanelsBottom {
  List<IdePanelBottom> children;
  String initId;

  final bool over;
  final double? height;
  final double? maxHeight;
  final double? minHeight;
  final IdePanelRightEventHandler? onInit;
  final IdePanelRightEventHandler? onClose;
  final IdePanelRightEventHandler? onShow;
  final IdePushedByHorizontal pushedByHorizontal;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final Clip clipBehavior;

  IdePanelsBottom({
    required this.children,
    this.initId = "",
    this.over = false,
    this.height = 300,
    this.maxHeight = 400,
    this.minHeight = 200,
    this.onInit,
    this.onClose,
    this.onShow,
    this.padding,
    this.margin,
    this.decoration,
    this.clipBehavior = Clip.antiAlias,
    this.pushedByHorizontal = const IdePushedByHorizontal(),
  }){
    for (IdePanelBottom panel in children) {
      panel.height ??= height;
      panel.maxHeight ??= maxHeight;
      panel.minHeight ??= minHeight;
      panel.padding ??= padding;
      panel.margin ??= margin;
      panel.decoration ??= decoration;
      panel.clipBehavior ??= clipBehavior;
      panel.pushedByHorizontal ??= pushedByHorizontal;
      panel.init();
    }
  }
}
