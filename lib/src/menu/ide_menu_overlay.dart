import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';

class IdeMenuOverlay extends StatefulWidget {
  const IdeMenuOverlay({super.key});

  @override
  State<IdeMenuOverlay> createState() => IdeMenuOverlayState();
}

class IdeMenuOverlayState extends State<IdeMenuOverlay> {
  Map<String, dynamic> menuItems = {};

  /// Posição atual do componente menubar no eixo y
  double topMenu = 28.0;

  /// Posição atual do componente no menubar eixo x
  double leftMenu = 30.0;

  /// Posição atual do componente submenu no eixo y
  double topSubmenu = 28.0;

  /// Posição atual do componente no submenu eixo x
  double leftSubmenu = 30.0;

  double? top = 0;
  double bottom = 0;
  double left = 30;
  double right = 0;

  //Status indica que a tela de overlay está habilitada
  bool isOverlay = false;

  Widget? renderMenu;
  Widget? renderSubmenu;

  void menuItemRegister(dynamic menuItem) {
    menuItems[menuItem.uid] = menuItem;
  }

  void menuItemRedraw() {
    menuItems.forEach((key, dynamic menuItem) {
      if (menuItem.mounted) {
        menuItem.setState(() {});
      }
    });
  }

  void configRenderMenu({required dynamic child, required RelativeRect rect}) {
    renderSubmenu = null;
    topMenu = rect.top;
    leftMenu = rect.left;
    renderMenu = child;
    setState(() {});
  }

  void configRenderSubmenu({required Widget child, required RelativeRect rect, required double width}) {
    topSubmenu = rect.top - 3;
    leftSubmenu = (rect.left + width) - 5;
    if (rect.left > (Get.width / 2)) {
      leftSubmenu = (rect.left - (width + 7));
    }
    renderSubmenu = child;
    setState(() {});
  }

  void resetMenu() {
    isOverlay = false;
    renderMenu = null;
    topMenu = 0;
    leftMenu = 0;
    Ide.selectedMenuUid = '';
    IdeMenu.activeMenuUid = '';
    IdeMenu.isMenuSelected = false;
    IdeMenu.activeMenuItemUid = '';
    IdeMenu.isMenuItemSelected = false;
    resetSubmenu();
    menuItemRedraw();
  }

  void resetSubmenu() {
    renderSubmenu = null;
    topSubmenu = 0;
    leftSubmenu = 0;
    IdeMenu.isSubmenuSelected = false;
    IdeMenu.activeSubmenuUid = '';
    setState(() {});
  }
  void hide(){
    setState(() {
      isOverlay = false;
      resetMenu();
    });
  }

  @override
  void initState() {
    Ide.initState("IdeMenuOverlayState", this);
    super.initState();
  }

  @override
  void dispose() {
    isOverlay = false;
    renderMenu = null;
    topMenu = 0;
    leftMenu = 0;
    Ide.selectedMenuUid = '';
    IdeMenu.activeMenuUid = '';
    IdeMenu.isMenuSelected = false;
    IdeMenu.activeMenuItemUid = '';
    IdeMenu.isMenuItemSelected = false;
    renderSubmenu = null;
    topSubmenu = 0;
    leftSubmenu = 0;
    IdeMenu.isSubmenuSelected = false;
    IdeMenu.activeSubmenuUid = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          IdeVisibilityBuilder(
            condition: true,
            child: () => Positioned(
              top: top,
              bottom: bottom,
              left: left,
              right: right,
              child: GestureDetector(
                onTap: () {
                  resetMenu();
                },
                child: Container(
                  color: isOverlay ? Colors.white.withValues(alpha:0.001) : null,
                ),
              ),
            ),
          ),
          IdeVisibilityBuilder(
            condition: topMenu > 0 && renderMenu != null,
            child: () => Positioned(
              top: topMenu,
              left: leftMenu,
              child: renderMenu!,
            ),
          ),
          IdeVisibilityBuilder(
            condition: renderSubmenu != null,
            child: () => Positioned(
              top: topSubmenu,
              left: leftSubmenu,
              child: renderSubmenu!,
            ),
          ),
        ],
      ),
    );
  }

  void resize() {
    if (Ide.hasMenubarLeft && Ide.menubarLeftVisible ) {
      left = Ide.menubarLeft!.position.left + Ide.menubarLeft!.size.width;
    }

    if (Ide.hasStatusbar && Ide.statusbarVisible) {
      bottom = Ide.statusbar!.position.bottom + Ide.statusbar!.size.height;
    }
    if (Ide.hasMenubarBottom && Ide.menubarBottomVisible) {
      bottom = Ide.menubarBottom!.position.bottom + Ide.menubarBottom!.size.height;
    }

    if (Ide.hasMenubarRight && Ide.menubarRightVisible) {
      right = Ide.menubarRight!.position.right + Ide.menubarRight!.size.width;
    }

    setState(() {});
  }
}
