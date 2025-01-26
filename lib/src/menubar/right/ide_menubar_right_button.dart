import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menu/ide_menu_abastract.dart';
import 'package:idea/src/menu/ide_menu_overlay.dart';
import 'package:idea/src/security/security.dart';
import 'package:idea/src/size/ide_position.dart';

// ignore: must_be_immutable
class IdeMenubarRightButton extends StatefulWidget {
  final bool enabled;
  final IconData icon;
  final bool divider;
  final VoidCallback onPressed;
  final double width;
  final double? menuWidth;
  final double height;
  final List<IdeMenuAbastract>? menu;
  final String tooltip;

  static bool isSubmenuSelected = false;
  static bool isMenuItemSelected = false;
  static String activeMenuUid = '';
  static String activeMenuItemUid = '';
  static String activeSubmenuUid = '';
  static bool isMenuSelected = false;

  const IdeMenubarRightButton({
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
  });

  @override
  State<IdeMenubarRightButton> createState() => _IdeMenubarRightButtonState();
}

class _IdeMenubarRightButtonState extends State<IdeMenubarRightButton> {
  String uid = ApiSecurity.uid();

  //========================================
  // isHover
  //========================================
  final RxBool _isHover = false.obs;

  set isHover(bool value) => _isHover.value = value;

  bool get isHover => _isHover.value;

  Offset btnOffset(RelativeRect btnRect, IdeMenuBoxRender menuBoxRender) {
    Offset btnOffset = Offset(-(widget.menuWidth!), -20);
    //Verifica se é menuTop
    if (btnRect.top < btnRect.bottom) {
      //Verifica se o menu extrapolou a janela
      double sizeBetweenBottomScreen = (btnRect.bottom + widget.height);
      if (sizeBetweenBottomScreen < menuBoxRender.menuBoxHeight) {
        double size = sizeBetweenBottomScreen - menuBoxRender.height;
        btnOffset = Offset(-(widget.menuWidth!), (-20 + size));
      } else {
        if (menuBoxRender.height > Get.height) {
          btnOffset = Offset(-(widget.menuWidth!), -((btnRect.top + widget.width) - 8));
        }
      }
    } else {
      //menuBotton
      btnOffset = Offset(-(widget.menuWidth!), -(menuBoxRender.height - 8));
      //Verifica se o menu extrapolou a janela
      double sizeBetweenBottomScreen = (btnRect.bottom + widget.height);
      if (sizeBetweenBottomScreen < menuBoxRender.menuBoxHeight) {
        double size = sizeBetweenBottomScreen - menuBoxRender.height;
        btnOffset = Offset(-(widget.menuWidth!), (-20 + size));
      } else {
        if (menuBoxRender.height > Get.height) {
          btnOffset = Offset(-(widget.menuWidth!), -((btnRect.top + widget.width) - 8));
        }
      }
    }
    return btnOffset;
  }

  Widget buildButton() {
    final IdeMenubarRightStyle defaultStyle = Theme.of(context).extension<IdeMenubarRightStyle>()!;

    final Color? iconColor = defaultStyle.iconColor;
    final Color? iconSelectedColor = defaultStyle.iconSelectedColor;
    final double? iconSize = defaultStyle.iconSize;

    final EdgeInsetsGeometry? indicatorMargin = defaultStyle.indicatorMargin;

    final BoxDecoration? buttonDecoration = defaultStyle.buttonDecoration;
    final BoxDecoration? buttonHoverDecoration = defaultStyle.buttonHoverDecoration;
    final BoxDecoration? buttonSelectedDecoration = defaultStyle.buttonSelectedDecoration;

    final BoxDecoration? indicatorDecoration = defaultStyle.indicatorDecoration;
    final BoxDecoration? indicatorSelectedDecoration = defaultStyle.indicatorSelectedDecoration;

    final EdgeInsetsGeometry? buttonPadding = defaultStyle.buttonPadding;
    final EdgeInsetsGeometry? buttonMargin = defaultStyle.buttonMargin;
    final double? indicatorWidth = defaultStyle.indicatorWidth;

    return Obx(
      () => Tooltip(
        child: InkWell(
          onTap: () {
            IdeMenuOverlayState? menuScreenOverlayState = Ide.state.find("IdeMenuOverlayState");
            if (menuScreenOverlayState != null) {
              if (widget.menu != null && widget.menu!.isNotEmpty) {
                if (isHover && mounted && Ide.menuOverlay != null) {
                  Ide.activeContent!.panelRightSelected = uid;

                  IdeMenuBoxRender menuBoxRender = IdeMenuBoxRender(width: widget.menuWidth!, children: widget.menu!);
                  RelativeRect btnRect = IdePosition.global(context, const Offset(0, 0));
                  menuScreenOverlayState.isOverlay = !menuScreenOverlayState.isOverlay;
                  IdeMenubarRightButton.isMenuSelected = menuScreenOverlayState.isOverlay;

                  menuScreenOverlayState.resize();

                  if (menuScreenOverlayState.isOverlay) {
                    Ide.activeContent!.panelRightSelected = uid;
                    menuScreenOverlayState.configRenderMenu(
                      child: menuBoxRender,
                      rect: IdePosition.global(context, btnOffset(btnRect, menuBoxRender)),
                    );
                  } else {
                    menuScreenOverlayState.hide();
                    Ide.activeContent!.panelRightSelected = '';
                  }
                }
              } else {
                menuScreenOverlayState.hide();
                Ide.activeContent!.panelRightSelected = '';
                widget.onPressed();
              }
            }
          },
          onHover: (bool value) {
            isHover = value;

            if (isHover && mounted && widget.menu != null && widget.menu!.isNotEmpty) {
              IdeMenuOverlayState? menuScreenOverlayState = Ide.state.find("IdeMenuOverlayState");
              if (menuScreenOverlayState != null) {
                IdeMenuBoxRender menuBoxRender = IdeMenuBoxRender(width: widget.menuWidth!, children: widget.menu!);
                RelativeRect btnRect = IdePosition.global(context, const Offset(0, 0));

                if (widget.enabled && Ide.menuOverlay != null) {
                  menuScreenOverlayState.menuItemRegister(this);
                  menuScreenOverlayState.resetSubmenu();
                  IdeMenubarRightButton.activeMenuUid = uid;
                  if (menuScreenOverlayState.isOverlay) {
                    menuScreenOverlayState.configRenderMenu(
                      child: menuBoxRender,
                      rect: IdePosition.global(context, btnOffset(btnRect, menuBoxRender)),
                    );
                  }
                  menuScreenOverlayState.menuItemRedraw();
                }

                if (menuScreenOverlayState.isOverlay) {
                  Ide.activeContent!.panelRightSelected = uid;
                } else {
                  menuScreenOverlayState.hide();
                  Ide.activeContent!.panelRightSelected = '';
                }
              }
            }
          },
          hoverColor: Colors.transparent,
          child: Column(
            children: [
              if (widget.divider) const Divider(height: 5),
              Container(
                padding: buttonPadding,
                margin: buttonMargin,
                alignment: Alignment.center,
                width: widget.width,
                height: widget.height,
                decoration: isHover ? buttonHoverDecoration : ((Ide.activeContent!.panelRightSelected == uid) ? buttonSelectedDecoration : buttonDecoration),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: widget.height - 2,
                        child: Center(
                          child: Icon(
                            widget.icon,
                            color: isHover || (Ide.activeContent!.panelRightSelected == uid) ? iconSelectedColor : iconColor,
                            size: iconSize,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: indicatorMargin,
                      alignment: Alignment.center,
                      width: indicatorWidth,
                      height: widget.height,
                      decoration: isHover || (Ide.activeContent!.panelRightSelected == uid) ? indicatorSelectedDecoration : indicatorDecoration,
                    ),
                  ],
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
