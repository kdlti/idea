import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menubar/right/ide_menubar_right_button_tab.dart';
import 'package:idea/src/size/ide_position.dart';

/// Classe que representa o menu à direita do ambiente de desenvolvimento (IDE).
class IdeMenubarRight {
  final IdePosition position = IdePosition();
  final IdeSize size = IdeSize();
  final IdeFunction layout;
  //final String uid = ApiSecurity.uidSha1("");
  final String uid = "";
  final String id = "menubarRight";
  final double width;
  final IdePushedByVertical pushedByVertical;
  final IdeMenubarRightStyle? style;

  bool visible;
  List<IdePanelRight> listPanelRight = [];
  List<Widget> startGroupButtons = [];
  List<Widget> endGroupButtons = [];
  List<Widget> result = [];

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final Clip? clipBehavior;

  final List<IdeMenubarRightButton>? startChildren;
  final List<IdeMenubarRightButton>? endChildren;

  IdeMenubarRight({
    required this.layout,
    this.visible = true,
    this.width = 36,
    this.pushedByVertical = const IdePushedByVertical(
      statusbar: true,
      menubar: true,
      appbar: true,
    ),
    this.startChildren,
    this.endChildren,
    this.style,
    this.padding,
    this.margin,
    this.decoration,
    this.clipBehavior = Clip.antiAlias,
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

    if (Ide.hasMenubarBottom && Ide.menubarBottomVisible && pushedByVertical.menubarBottom) {
      position.bottom = Ide.menubarBottom!.position.bottom + Ide.menubarBottom!.size.height;
    }
    if (Ide.hasPanelBottom && Ide.panelBottomVisible && pushedByVertical.panelBottom) {
      position.bottom = Ide.panelBottom!.position.bottom + Ide.panelBottom!.size.height;
    }
    if (Ide.hasStatusbar && Ide.statusbarVisible && pushedByVertical.statusbar) {
      position.bottom = Ide.statusbar!.position.bottom + Ide.statusbar!.size.height;
    }
  }

  void _addButtonsInfo() {
    startGroupButtons = [];
    endGroupButtons = [];
    if (Ide.menubarRight != null) {
      for (var item in listPanelRight) {
        if (item.buttonMenu != null) {
          startGroupButtons.add(
            IdeMenubarRightButtonTab(
              tooltip: item.buttonMenu!.tooltip,
              onPressed: () {
                Ide.activeContent!.panelRightManager.middlewaresOnPanelHide();
                Ide.showPanelRight(item.id, redraw: true);
                if(item.buttonMenu!.onPressed != null) {
                  item.buttonMenu!.onPressed!();
                }
              },
              icon: item.buttonMenu!.icon,
              iconSvg: item.buttonMenu!.iconSvg,
              height: Ide.menubarRight!.size.width,
              width: Ide.menubarRight!.size.width,
              uid: item.uid,
            ),
          );
        }
      }
    }
  }

  void _addButtons(List<IdeMenubarRightButton>? startButtons, List<IdeMenubarRightButton>? endChildren) {
    if (Ide.menubarRight != null) {
      if (startButtons != null) {
        startGroupButtons.addAll(startButtons);
      }
      if (endChildren != null) {
        endGroupButtons.addAll(endChildren);
      }
    }
  }

  /// Combina os widgets do menu.
  List<Widget> _mergeWidget() {
    List<Widget> result = [];
    result.addAll(startGroupButtons);
    result.add(const Spacer());
    result.addAll(endGroupButtons);
    return result;
  }

  List<Widget> build(List<IdeMenubarRightButton>? startButtons, List<IdeMenubarRightButton>? endChildren) {
    if (result.isEmpty) {
      _addButtonsInfo();
      _addButtons(startButtons, endChildren);
      result = _mergeWidget();
    }
    return result;
  }

  Widget? rendered;

  Widget render() {
    return rendered ??= layout();
  }
}
