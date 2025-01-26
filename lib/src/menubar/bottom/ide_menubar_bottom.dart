import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menubar/bottom/ide_menubar_bottom_button_tab.dart';
import 'package:idea/src/size/ide_position.dart';

enum IdeAddToMenubarBottom { tab, buttons, none }

class IdeMenubarBottom {
  /// O widget filho para o menu inferior.
  final IdeFunction<IdeMenubarBottomConfig> child;

  /// A posição do menu inferior.
  final IdePosition position = IdePosition();

  /// O tamanho do menu inferior.
  final IdeSize size = IdeSize();

  final IdePushedByHorizontal pushedByHorizontal;

  /// A visibilidade do menu inferior.
  bool visible;

  /// Uma lista de botões de grupo de início para o menu inferior.
  List<Widget> _groupTabMenu = [];

  /// Uma lista de botões de grupo final para o menu inferior.
  List<Widget> _groupButtons = [];

  /// Uma lista de painéis inferiores para o menu inferior.
  List<Widget> result = [];

  /// Uma lista de temas para o menu inferior.
  List<IdePanelBottom> listPanelsBottom = [];

  //final String uid = ApiSecurity.uidSha1("menubarBottom");
  final String uid = "menubarBottom";
  final String id = "menubarBottom";

  final IdeMenubarBottomStyle? style;
  final double? height;

  /// Construtor para a classe IdeMenubarBottom.
  IdeMenubarBottom({
    required this.child,
    this.visible = true,
    this.pushedByHorizontal = const IdePushedByHorizontal(),
    this.style,
    this.height = 22,
  }) {
    resize();
  }

  /// Redimensiona o menu inferior.
  void resize() {
    size.height = height!;
    position.reset();

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

    if (Ide.hasStatusbar && Ide.statusbarVisible) {
      position.bottom = Ide.statusbar!.position.bottom + Ide.statusbar!.size.height;
    }
  }

  Widget? rendered;

  /// Renderiza o widget filho do menu inferior.
  Widget render() {
    return rendered ??= child();
  }

  /// Adiciona botões para os painéis inferiores.
  void _addGroupTabMenu() {
    _groupTabMenu = [];

    // Adiciona botões para cada painel inferior.
    if (Ide.menubarBottom != null) {
      for (var item in listPanelsBottom) {
        if (item.addToGroup == IdeAddToMenubarBottom.tab) {
          _groupTabMenu.add(IdeMenubarBottomButtonTab(
            onPressed: () {
              Ide.panelBottomToggle(item.uid);
            },
            uid: item.uid,
            icon: item.icon,
            label: item.label,
            tooltip: item.tooltip,
          ));
        } else if (item.addToGroup == IdeAddToMenubarBottom.buttons) {
          _groupButtons.add(IdeMenubarBottomButtonTab(
            onPressed: () {
              Ide.panelBottomToggle(item.uid);
            },
            uid: item.uid,
            icon: item.icon,
            label: item.label,
            tooltip: item.tooltip,
          ));
        }
      }
    }
  }

  /// Adiciona botões ao grupo final.
  void _addGroupButtons(List<IdeMenubarBottomButton>? endChildren) {
    // Adiciona botões ao grupo final se houver botões e o menu inferior existir.
    if (Ide.menubarBottom != null && endChildren != null && endChildren.isNotEmpty) {
      for (var button in endChildren) {
        _groupButtons.add(button);
      }
    }
  }

  /// Combina a lista de botões em um único widget.
  List<Widget> _mergeWidget() {
    List<Widget> result = [];
    result.addAll(_groupTabMenu);
    result.add(const Spacer());
    result.addAll(_groupButtons);
    return result;
  }

  /// Cria uma lista de widgets para renderizar o menu inferior.
  List<Widget> build(List<IdeMenubarBottomButton>? endChildren) {
    if (result.isEmpty) {
      _groupButtons = [];
      _addGroupTabMenu();
      _addGroupButtons(endChildren);
      result = _mergeWidget();
    }
    return result;
  }
}
