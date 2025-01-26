import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

class IdeStatusbar {
  final IdePosition position = IdePosition();
  final IdeSize size = IdeSize();
  final IdePushedByHorizontal pushedByHorizontal;
  final IdeFunction child;
  final double height;

  bool visible;
  //String uid = ApiSecurity.uidSha1("statusbar");
  String uid = "statusbar";
  String id = "statusbar";

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final Clip clipBehavior;

  IdeStatusbar({
    required this.child,
    this.visible = true,
    this.height = 25,
    this.padding,
    this.margin,
    this.decoration,
    this.clipBehavior = Clip.antiAlias,
    this.pushedByHorizontal = const IdePushedByHorizontal(),
  }) {
    resize();
  }

  void resize() {
    double totalHeight = height ?? 40.0;
    if (margin != null) {
      // Resolve a margem em relação à direção do texto (esquerda para a direita).
      final EdgeInsets resolvedMargin = margin!.resolve(TextDirection.ltr);
      // Adiciona as margens superior e inferior à altura total.
      totalHeight += resolvedMargin.top + resolvedMargin.bottom;
    }
    // Define a altura calculada no tamanho da barra de aplicativos.
    size.height = totalHeight;

    position.reset();

    if (Ide.hasMenubarLeft && Ide.menubarLeftVisible && pushedByHorizontal.menubarLeft) {
      position.left = Ide.menubarLeft!.position.left + Ide.menubarLeft!.size.width;
    }
    if (Ide.hasPanelLeft && Ide.panelLeftVisible && pushedByHorizontal.panelLeft) {
      position.left = position.left + Ide.panelLeft!.position.left + Ide.panelLeft!.size.width;
    }
    if (Ide.hasMenubarRight && Ide.menubarRightVisible && pushedByHorizontal.menubarRight) {
      position.right = Ide.menubarRight!.position.right + Ide.menubarRight!.size.width;
    }
    if (Ide.hasPanelRight && Ide.panelRightVisible && pushedByHorizontal.panelRight) {
      position.right = Ide.panelRight!.position.right + Ide.panelRight!.size.width;
    }
  }

  Widget? rendered;

  Widget render() {
    return rendered ??= child();
  }
}
