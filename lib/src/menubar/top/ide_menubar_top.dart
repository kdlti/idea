import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menubar/top/ide_menubar_top_button.dart';
import 'package:idea/src/size/ide_position.dart';

typedef IdeMenubarTopButtons<Widget> = List<Widget> Function();

class IdeMenubarTop {
  final IdeFunction<IdeMenubarTopConfig>? child;
  final IdePosition position = IdePosition();
  final IdeSize size = IdeSize();
  final double? height;
  //final String uid = ApiSecurity.uidSha1("tabbar");
  final String uid = "tabbar";
  final String id = "tabbar";
  final IdePushedByHorizontal pushedByHorizontal;
  bool visible;
  final List<IdeMenubarTopButtonState> buttonsState = [];

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final Clip clipBehavior;
  final IdeTabbar? tabbar;

  IdeMenubarTop({
    this.child,
    this.visible = true,
    this.height = 28,
    this.pushedByHorizontal = const IdePushedByHorizontal(
      panelRight: true,
      panelLeft: true,
      menubarLeft: true,
      menubarRight: true,
    ),
    this.padding,
    this.margin,
    this.decoration,
    this.clipBehavior = Clip.antiAlias,
    this.tabbar,
  }) {
    resize();
  }

  void addButtonState(IdeMenubarTopButtonState state) {
    buttonsState.add(state);
  }

  void redrawButtonState() {
    for (final IdeMenubarTopButtonState state in buttonsState) {
      state.redraw();
    }
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

    position.reset();

    if (Ide.hasAppbar && Ide.appbarVisible) {
      position.top = Ide.appbar!.position.top + Ide.appbar!.size.height;
    }
    if (Ide.hasToolbar && Ide.toolbarVisible) {
      position.top = Ide.toolbar!.position.top + Ide.toolbar!.size.height;
    }
    if (Ide.hasMenubarLeft && Ide.menubarLeftVisible && pushedByHorizontal.menubarLeft) {
      position.left = Ide.menubarLeft!.position.left + Ide.menubarLeft!.size.width;
    }
    if (Ide.hasPanelLeft && Ide.panelLeftVisible && pushedByHorizontal.panelLeft) {
      position.left = Ide.panelLeft!.position.left + Ide.panelLeft!.size.width;
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
    if (child == null) {
      return const SizedBox.shrink();
    }
    return child!();
  }
}
