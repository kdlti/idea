import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menu/ide_menu_abastract.dart';
import 'package:idea/src/menu/ide_menu_overlay.dart';
import 'package:idea/src/size/ide_position.dart';

class IdeMenu extends StatefulWidget {
  final bool enabled;
  final List<IdeMenuAbastract> children;
  final String title;
  final double width;
  final double height;

  static bool isSubmenuSelected = false;
  static bool isMenuItemSelected = false;
  static String activeMenuUid = '';
  static String activeMenuItemUid = '';
  static String activeSubmenuUid = '';
  static bool isMenuSelected = false;

  const IdeMenu({
    this.enabled = true,
    required this.children,
    required this.title,
    this.width = 200,
    this.height = 24,
    super.key,
  });

  @override
  IdeMenuState createState() => IdeMenuState();
}

class IdeMenuState extends State<IdeMenu> {
  String uid = '';
  ThemeData? theme;

  /// Status indica se o componente está habilitado
  bool isEnabled = true;

  /// Status indica se o componente está com evento de hover
  bool isHover = false;

  Color get backgroundColor {
    return (isEnabled && (isHover || IdeMenu.isMenuSelected && IdeMenu.activeMenuUid == uid)) ? theme!.primaryColor : Colors.transparent;
  }

  Color get color {
    if ((isEnabled && (isHover || IdeMenu.isMenuSelected && IdeMenu.activeMenuUid == uid))) {
      return Colors.white;
    } else if (isEnabled) {
      return Colors.black;
    } else {
      return Colors.black38;
    }
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    //uid = ApiSecurity.uidSha1(widget.title);
    uid = widget.title;
    isHover = Ide.selectedMenuUid == uid;

    return MouseRegion(
      onEnter: (PointerEvent e) {
        if (mounted) {
          setState(
            () {
              isHover = true;
              Ide.selectedMenuUid = uid;
              if (isEnabled) {
                if (Ide.menuOverlay != null) {
                  IdeMenuOverlayState? menuScreenOverlayState = Ide.state.find("IdeMenuOverlayState");
                  if (menuScreenOverlayState != null) {
                    menuScreenOverlayState.menuItemRegister(this);
                    menuScreenOverlayState.resetSubmenu();

                    IdeMenu.activeMenuUid = uid;
                    if (menuScreenOverlayState.isOverlay) {
                      menuScreenOverlayState.configRenderMenu(
                        child: IdeMenuBoxRender(width: widget.width, children: widget.children),
                        rect: IdePosition.global(context, Offset.zero),
                      );
                    }
                    menuScreenOverlayState.menuItemRedraw();
                  }
                }
              }
            },
          );
        }
      },
      onExit: (PointerEvent e) {
        isHover = false;
        Ide.selectedMenuUid = '';
        setState(() {});
      },
      child: GestureDetector(
        onTap: () {
          if (Ide.menuOverlay != null) {
            IdeMenuOverlayState? menuScreenOverlayState = Ide.state.find("IdeMenuOverlayState");

            if (menuScreenOverlayState != null) {
              menuScreenOverlayState.isOverlay = !menuScreenOverlayState.isOverlay;
              IdeMenu.isMenuSelected = menuScreenOverlayState.isOverlay;

              /// Posição atual do componente menubar no eixo y
              menuScreenOverlayState.top = 28;

              /// Posição atual do componente no menubar eixo x
              menuScreenOverlayState.left = 0;

              /// Posição atual do componente submenu no eixo y
              menuScreenOverlayState.bottom = 0;

              /// Posição atual do componente no submenu eixo x
              menuScreenOverlayState.right = 0;

              menuScreenOverlayState.setState(() {});

              if (menuScreenOverlayState.isOverlay) {
                menuScreenOverlayState.configRenderMenu(
                  child: IdeMenuBoxRender(width: widget.width, children: widget.children),
                  rect: IdePosition.global(context, Offset.zero),
                );
              } else {
                menuScreenOverlayState.resetMenu();
              }
            }
          }
        },
        child: Container(
          height: widget.height,
          padding: const EdgeInsets.only(left: 7, top: 3, right: 7),
          margin: const EdgeInsets.only(top: 3),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 13, color: color),
          ),
        ),
      ),
    );
  }
}
