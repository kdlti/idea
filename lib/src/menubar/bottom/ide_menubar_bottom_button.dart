import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menu/ide_menu_abastract.dart';
import 'package:idea/src/menu/ide_menu_overlay.dart';
import 'package:idea/src/security/security.dart';
import 'package:idea/src/size/ide_position.dart';

// ignore: must_be_immutable
class IdeMenubarBottomButton extends StatefulWidget {
  final bool enabled;
  final IconData icon;
  final bool divider;
  final VoidCallback onPressed;
  final double width;
  final double? menuWidth;
  final double height;
  final List<IdeMenuAbastract>? menu;

  static bool isSubmenuSelected = false;
  static bool isMenuItemSelected = false;
  static String activeMenuUid = '';
  static String activeMenuItemUid = '';
  static String activeSubmenuUid = '';
  static bool isMenuSelected = false;

  String tooltip;
  String label;

  IdeMenubarBottomButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.width,
    required this.height,
    this.enabled = true,
    this.divider = false,
    this.menuWidth = 240,
    this.menu,
    this.tooltip = "",
    this.label = "",
  });

  @override
  State<IdeMenubarBottomButton> createState() => _IdeMenubarBottomButtonState();
}

class _IdeMenubarBottomButtonState extends State<IdeMenubarBottomButton> {
  String uid = ApiSecurity.uid();
  bool isHover = false;

  Offset btnOffset(RelativeRect btnRect, IdeMenuBoxRender menuBoxRender) {
    Offset btnOffset = Offset(-(widget.menuWidth!), -20);
    //menuBotton
    btnOffset = Offset(-(widget.menuWidth!) + widget.width + 3, -(menuBoxRender.height + (widget.height - 4)));
    //Verifica se o menu extrapolou a janela
    double sizeBetweenBottomScreen = (btnRect.bottom + widget.height);
    if (sizeBetweenBottomScreen < menuBoxRender.menuBoxHeight) {
      double size = sizeBetweenBottomScreen - menuBoxRender.height;
      btnOffset = Offset(-(widget.menuWidth!), (-20 + size));
    } else {
      if (menuBoxRender.height + sizeBetweenBottomScreen > Get.height) {
        btnOffset = Offset(-(widget.menuWidth!), -btnRect.top);
      }
    }
    return btnOffset;
  }

  Widget buildButton() {
    return Tooltip(
      message: widget.tooltip,
      child: InkWell(
        onTap: () {
          IdeMenuOverlayState? menuScreenOverlayState = Ide.state.find("IdeMenuOverlayState");

          if (widget.menu != null && widget.menu!.isNotEmpty) {
            if (isHover && mounted && Ide.menuOverlay != null) {
              Ide.selectedMenuUid = uid;

              IdeMenuBoxRender menuBoxRender = IdeMenuBoxRender(width: widget.menuWidth!, children: widget.menu!);
              RelativeRect btnRect = IdePosition.global(context, const Offset(0, 0));

              if (menuScreenOverlayState != null) {
                menuScreenOverlayState.isOverlay = !menuScreenOverlayState.isOverlay;
                IdeMenubarBottomButton.isMenuSelected = menuScreenOverlayState.isOverlay;

                menuScreenOverlayState.resize();

                if (menuScreenOverlayState.isOverlay) {
                  menuScreenOverlayState.configRenderMenu(
                    child: menuBoxRender,
                    rect: IdePosition.global(context, btnOffset(btnRect, menuBoxRender)),
                  );
                } else {
                  menuScreenOverlayState.hide();
                  Ide.selectedMenuUid = '';
                }
              }
            }
          } else {
            if (menuScreenOverlayState != null) {
              menuScreenOverlayState.hide();
            }
            Ide.selectedMenuUid = '';
            widget.onPressed();
          }

          setState(() {});
        },
        onHover: (bool value) {
          IdeMenuOverlayState? menuScreenOverlayState = Ide.state.find("IdeMenuOverlayState");
          isHover = value;

          if (isHover && mounted && widget.menu != null && widget.menu!.isNotEmpty) {
            IdeMenuBoxRender menuBoxRender = IdeMenuBoxRender(width: widget.menuWidth!, children: widget.menu!);
            RelativeRect btnRect = IdePosition.global(context, const Offset(0, 0));
            if (menuScreenOverlayState != null) {
              if (widget.enabled && Ide.menuOverlay != null) {
                menuScreenOverlayState.menuItemRegister(this);
                menuScreenOverlayState.resetSubmenu();
                IdeMenubarBottomButton.activeMenuUid = uid;
                if (menuScreenOverlayState.isOverlay) {
                  menuScreenOverlayState.configRenderMenu(
                    child: menuBoxRender,
                    rect: IdePosition.global(context, btnOffset(btnRect, menuBoxRender)),
                  );
                }
                menuScreenOverlayState.menuItemRedraw();
              }
              if (menuScreenOverlayState.isOverlay) {
                Ide.selectedMenuUid = uid;
              } else {
                menuScreenOverlayState.hide();
                Ide.selectedMenuUid = '';
              }
            }
          }

          setState(() {});
        },
        hoverColor: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          height: widget.height,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 4, left: 6, right: 6),
                alignment: Alignment.center,
                height: 20,
                child: Row(
                  children: [
                    Icon(
                      widget.icon,
                      color: isHover || (Ide.selectedMenuUid == uid) ? Colors.blue[500] : const Color(0xFF767676),
                      size: widget.height * .55,
                    ),
                    if (widget.label.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          widget.label,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                alignment: Alignment.center,
                height: 3,
                decoration: BoxDecoration(
                  color: isHover || (Ide.selectedMenuUid == uid) ? Colors.blue[500] : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 3, left: 6, right: 6),
                  alignment: Alignment.center,
                  height: widget.height - 4,
                  child: Row(
                    children: [
                      Icon(
                        widget.icon,
                        color: Colors.transparent,
                        size: widget.height * .6,
                      ),
                      if (widget.label.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            widget.label,
                            style: const TextStyle(fontSize: 12, color: Colors.transparent),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IdeVisibilityToggle(
      condition: widget.enabled,
      firstChild: () => buildButton(),
      secondChild: () => IgnorePointer(
        ignoring: true,
        child: Opacity(
          opacity: 0.3,
          child: buildButton(),
        ),
      ),
    );
  }
}
