import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';


//TODO: Analisa a necessidade de implementar este componente.
class IdePanelLeft<PanelLeft>  {
  final List<IdeMenubarLeftButton> listMenuButtons = [];
  final IdeFunction child;
  final IdePosition position = IdePosition();
  final IdeSize size = IdeSize();
  //final String uid = ApiSecurity.uidSha1("panelLeft");
  final String uid = "panelLeft";
  final String id = "panelLeft";
  final IdePushedByVertical pushedByVertical;
  final double width;
  final bool over;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final Clip clipBehavior;

  bool visible;

  IdePanelLeft({
    required this.child,
    this.visible = true,
    this.width = 250,
    this.over = false,
    this.padding,
    this.margin,
    this.decoration,
    this.clipBehavior = Clip.antiAlias,
    this.pushedByVertical = const IdePushedByVertical(
      menubar: true,
      appbar: true,
      toolbar: false,
      menubarTop: false,
      statusbar: true,
      menubarBottom: false,
      panelBottom: false,
    ),
  }) {
    resize();
  }

  void resize() {

    double totalWidth = width;
    if (margin != null) {
      // Resolve a margem em relação à direção do texto (esquerda para a direita).
      final EdgeInsets resolvedMargin = margin!.resolve(TextDirection.ltr);
      // Adiciona as margens superior e inferior à altura total.
      totalWidth += resolvedMargin.left + resolvedMargin.right;
    }
    // Define a altura calculada no tamanho da barra de aplicativos.
    size.width = totalWidth;

    position.reset();

    if (Ide.hasAppbar && Ide.appbarVisible && pushedByVertical.appbar) {
      position.top = Ide.appbar!.position.top + Ide.appbar!.size.height;
    }

    if (Ide.hasToolbar && Ide.toolbarVisible && pushedByVertical.toolbar) {
      position.top = Ide.toolbar!.position.top + Ide.toolbar!.size.height;
    }
    if (Ide.hasMenubarTop && Ide.menubarTopVisible && pushedByVertical.menubarTop) {
      position.top = Ide.menubarTop!.position.top + Ide.menubarTop!.size.height;
    }

    if (Ide.hasStatusbar && Ide.statusbarVisible && pushedByVertical.statusbar) {
      position.bottom = Ide.statusbar!.position.bottom + Ide.statusbar!.size.height;
    }
    if (Ide.hasMenubarBottom && Ide.menubarBottomVisible && pushedByVertical.menubarBottom) {
      position.bottom = position.bottom + Ide.menubarBottom!.position.bottom + Ide.menubarBottom!.size.height;
    }
    if (Ide.hasPanelBottom && Ide.panelBottomVisible && pushedByVertical.panelBottom) {
      position.bottom = Ide.panelBottom!.position.bottom + Ide.panelBottom!.size.height;
    }

    if (Ide.hasMenubarLeft && Ide.menubarLeftVisible) {
      position.left = Ide.menubarLeft!.position.left + Ide.menubarLeft!.size.width;
    }
  }

  Widget? rendered;
  Widget render() {
    return rendered ??= child();
  }
}
