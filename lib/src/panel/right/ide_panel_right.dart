import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/size/ide_position.dart';

typedef IdePanelRightEventHandler = void Function(IdeContent content)?;

class IdePanelRight {
  final IdeFunction child;
  final List<IdePanelRightMiddleware>? middlewares;

  final IdePosition position = IdePosition();
  final IdeSize size = IdeSize();

  bool visible = false;
  String uid = "";
  String id;

  final IdePanelRightButtonMenu? buttonMenu;

  bool? overlay;
  double? width;
  IdePushedByVertical? pushedByVertical;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  BoxDecoration? decoration;
  Clip? clipBehavior;

  /// Indica se o painel foi inicializado. - Utilizado para evitar a inicialização múltipla.
  bool initialized = false;

  IdePanelRight({
    required this.child,
    required this.id,
    this.buttonMenu,
    this.overlay = true,
    this.width,
    this.padding,
    this.margin,
    this.decoration,
    this.clipBehavior,
    this.pushedByVertical,
    this.middlewares,
  });

  void init() {
    //uid = ApiSecurity.uidSha1(id);
    uid = id;
    resize();
  }

  void resize() {
    double totalWidth = width!;
    if (margin != null) {
      // Resolve a margem em relação à direção do texto (esquerda para a direita).
      final EdgeInsets resolvedMargin = margin!.resolve(TextDirection.ltr);
      // Adiciona as margens superior e inferior à altura total.
      totalWidth += resolvedMargin.left + resolvedMargin.right;
    }
    // Define a altura calculada no tamanho da barra de aplicativos.
    size.width = totalWidth;

    position.reset();

    if (Ide.hasAppbar && Ide.appbarVisible && pushedByVertical!.appbar) {
      position.top = Ide.appbar!.position.top + Ide.appbar!.size.height;
    }
    if (Ide.hasToolbar && Ide.toolbarVisible && pushedByVertical!.toolbar) {
      position.top = Ide.toolbar!.position.top + Ide.toolbar!.size.height;
    }
    if (Ide.hasMenubarTop && Ide.menubarTopVisible && pushedByVertical!.menubarTop) {
      position.top = Ide.menubarTop!.position.top + Ide.menubarTop!.size.height;
    }
    if (Ide.hasStatusbar && Ide.statusbarVisible && pushedByVertical!.statusbar) {
      position.bottom = Ide.statusbar!.position.bottom + Ide.statusbar!.size.height;
    }
    if (Ide.hasMenubarBottom && Ide.menubarBottomVisible && pushedByVertical!.menubarBottom) {
      position.bottom = Ide.menubarBottom!.position.bottom + Ide.menubarBottom!.size.height;
    }
    if (Ide.hasPanelBottom && Ide.panelBottomVisible && pushedByVertical!.panelBottom) {
      position.bottom = Ide.panelBottom!.position.bottom + Ide.panelBottom!.size.height;
    }
    if (Ide.hasMenubarRight && Ide.menubarRightVisible) {
      position.right = Ide.menubarRight!.position.right + Ide.menubarRight!.size.width;
    }
  }

  Widget? rendered;
  Widget render() {
    return rendered ??= child();
  }
}
