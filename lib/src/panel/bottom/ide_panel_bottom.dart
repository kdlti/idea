import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

typedef IdePanelBottomEventHandler = void Function(IdePanelBottomEvent config)?;

class IdePanelBottom {
  final IdeFunction layout;
  final String label;
  final String tooltip;
  final IconData icon;
  final IdePanelBottomEventHandler? onInit;
  final IdePanelBottomEventHandler? onClose;
  final IdePosition position = IdePosition();
  final IdeSize size = IdeSize();
  final String id;
  final IdeAddToMenubarBottom addToGroup;

  double splitWidth = 4;
  double splitPosition = 5;

  bool initialized = false;
  bool visible = false;
  //bool isResize;
  bool isRegistered = false;
  String uid = "";

  double? height;
  double? maxHeight;
  double? minHeight;
  IdePushedByHorizontal? pushedByHorizontal;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  BoxDecoration? decoration;
  Clip? clipBehavior;

  IdePanelBottom({
    required this.layout,
    required this.id,
    required this.icon,
    this.onInit,
    this.onClose,
    this.label = '',
    this.tooltip = '',
    this.addToGroup = IdeAddToMenubarBottom.tab,
    //this.isResize = true,
    this.pushedByHorizontal,
    this.height,
    this.maxHeight,
    this.minHeight,
    this.padding,
    this.margin,
    this.decoration,
    this.clipBehavior,
  });

  void init() {
    //uid = ApiSecurity.uidSha1(id);
    uid = id;
    resize();
  }

  void resize() {
    double totalHeight = height!;
    if (margin != null) {
      // Resolve a margem em relação à direção do texto (esquerda para a direita).
      final EdgeInsets resolvedMargin = margin!.resolve(TextDirection.ltr);
      // Adiciona as margens superior e inferior à altura total.
      totalHeight += resolvedMargin.top + resolvedMargin.bottom;
    }
    // Define a altura calculada no tamanho da barra de aplicativos.
    size.height = totalHeight;
    size.maxHeight = maxHeight!;
    size.minHeight = minHeight!;

    if (size.height > size.maxHeight) {
      size.height = size.maxHeight;
    }
    if (size.height < size.minHeight) {
      size.height = size.minHeight;
    }

    position.left = 0;
    position.right = 0;

    if (Ide.hasMenubarLeft && Ide.menubarLeftVisible && pushedByHorizontal!.menubarLeft) {
      position.left = Ide.menubarLeft!.position.left + Ide.menubarLeft!.size.width;
    }
    if (Ide.hasPanelLeft && Ide.panelLeftVisible && pushedByHorizontal!.panelLeft) {
      position.left = Ide.panelLeft!.position.left + Ide.panelLeft!.size.width;
    }
    if (Ide.hasMenubarRight && Ide.menubarRightVisible && pushedByHorizontal!.menubarRight) {
      position.right = Ide.menubarRight!.position.right + Ide.menubarRight!.size.width;
    }

    if (Ide.hasPanelRight && Ide.panelRightVisible && pushedByHorizontal!.panelRight) {
      position.right = Ide.panelRight!.position.right + Ide.panelRight!.size.width;
    }

    if (Ide.hasStatusbar) {
      position.bottom = Ide.statusbar!.position.bottom + Ide.statusbar!.size.height;
    }
    if (Ide.hasMenubarBottom) {
      position.bottom = Ide.menubarBottom!.position.bottom + Ide.menubarBottom!.size.height;
    }
  }

  Widget? rendered;

  Widget render() {
    return rendered ??= layout();
  }
}
