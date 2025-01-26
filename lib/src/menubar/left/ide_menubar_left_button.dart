import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menu/ide_menu_abastract.dart';
import 'package:idea/src/menu/ide_menu_overlay.dart';
import 'package:idea/src/security/security.dart';
import 'package:idea/src/size/ide_position.dart';

// ignore: must_be_immutable
class IdeMenubarLeftButton extends StatefulWidget {
  final bool enabled;
  final IconData icon;
  final String? iconSvg;
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

  const IdeMenubarLeftButton({
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
    this.iconSvg,
  });

  @override
  State<IdeMenubarLeftButton> createState() => _IdeMenubarLeftButtonState();
}

class _IdeMenubarLeftButtonState extends State<IdeMenubarLeftButton> {
  String uid = ApiSecurity.uid();

  Offset btnOffset(RelativeRect btnRect, IdeMenuBoxRender menuBoxRender) {
    Offset btnOffset = Offset(widget.width, -25);

    //Verifica se é menuTop
    if (btnRect.top < btnRect.bottom) {
      //Verifica se o menu extrapolou a janela
      double sizeBetweenBottomScreen = (btnRect.bottom + widget.height);
      if (sizeBetweenBottomScreen < menuBoxRender.menuBoxHeight) {
        double size = sizeBetweenBottomScreen - menuBoxRender.height;
        btnOffset = Offset(widget.width, (-25 + size));
      } else {
        if (menuBoxRender.height > Get.height) {
          btnOffset = Offset(widget.width, -((btnRect.top + widget.width) - 8));
        }
      }
    } else {
      //menuBotton
      btnOffset = Offset(widget.width, -(menuBoxRender.height - 5));
      //Verifica se o menu extrapolou a janela
      double sizeBetweenBottomScreen = (btnRect.bottom + widget.height);
      if (sizeBetweenBottomScreen < menuBoxRender.menuBoxHeight) {
        double size = sizeBetweenBottomScreen - menuBoxRender.height;
        btnOffset = Offset(widget.width, (-25 + size));
      } else {
        if (menuBoxRender.height > Get.height) {
          btnOffset = Offset(widget.width, -((btnRect.top + widget.width) - 8));
        }
      }
    }
    return btnOffset;
  }

  Widget buildButton() {
    final IdeMenubarLeftStyle defaultStyle = Theme.of(context).extension<IdeMenubarLeftStyle>()!;

    final Color? iconColor = defaultStyle.iconColor;
    final Color? iconSelectedColor = defaultStyle.iconSelectedColor;
    //final double? iconSize = defaultStyle.iconSize;
    const double? iconSize = 18;

    final EdgeInsetsGeometry? indicatorMargin = defaultStyle.indicatorMargin;

    final BoxDecoration? buttonDecoration = defaultStyle.buttonDecoration;
    final BoxDecoration? buttonHoverDecoration = defaultStyle.buttonHoverDecoration;
    final BoxDecoration? buttonSelectedDecoration = defaultStyle.buttonSelectedDecoration;

    final BoxDecoration? indicatorDecoration = defaultStyle.indicatorDecoration;
    final BoxDecoration? indicatorSelectedDecoration = defaultStyle.indicatorSelectedDecoration;

    final EdgeInsetsGeometry? buttonPadding = defaultStyle.buttonPadding;
    final EdgeInsetsGeometry? buttonMargin = defaultStyle.buttonMargin;
    final double? indicatorWidth = defaultStyle.indicatorWidth;

    return MouseRegion(
      onEnter: (value) {
        setState(
          () {
            Ide.hoverLeftMenuButtonUid = uid;

            if (mounted && widget.menu != null && widget.menu!.isNotEmpty) {
              IdeMenuOverlayState? menuScreenOverlayState = Ide.state.find("IdeMenuOverlayState");
              IdeMenuBoxRender menuBoxRender = IdeMenuBoxRender(width: widget.menuWidth!, children: widget.menu!);
              RelativeRect btnRect = IdePosition.global(context, const Offset(0, 0));

              if (menuScreenOverlayState != null) {
                if (widget.enabled && Ide.menuOverlay != null) {
                  menuScreenOverlayState.menuItemRegister(this);
                  menuScreenOverlayState.resetSubmenu();
                  IdeMenubarLeftButton.activeMenuUid = uid;
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
          },
        );
      },
      onExit: (value) {
        setState(() {
          Ide.hoverLeftMenuButtonUid = '';
        });
      },
      child: Tooltip(
        message: widget.tooltip,
        child: InkWell(
          onTap: () {
            IdeMenuOverlayState? menuScreenOverlayState = Ide.state.find("IdeMenuOverlayState");

            if (widget.menu != null && widget.menu!.isNotEmpty) {
              if (Ide.hoverLeftMenuButtonUid == uid && mounted && Ide.menuOverlay != null) {
                Ide.selectedMenuUid = uid;
                if (menuScreenOverlayState != null) {
                  IdeMenuBoxRender menuBoxRender = IdeMenuBoxRender(width: widget.menuWidth!, children: widget.menu!);
                  RelativeRect btnRect = IdePosition.global(context, const Offset(0, 0));
                  menuScreenOverlayState.isOverlay = !menuScreenOverlayState.isOverlay;
                  IdeMenubarRightButton.isMenuSelected = menuScreenOverlayState.isOverlay;

                  menuScreenOverlayState.resize();

                  if (menuScreenOverlayState.isOverlay) {
                    Ide.selectedMenuUid = uid;
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
                decoration: Ide.hoverLeftMenuButtonUid == uid
                    ? buttonHoverDecoration
                    : ((Ide.selectedMenuUid == uid) ? buttonSelectedDecoration : buttonDecoration),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: indicatorMargin,
                      alignment: Alignment.center,
                      width: indicatorWidth,
                      height: widget.height,
                      decoration: Ide.hoverLeftMenuButtonUid == uid || (Ide.selectedMenuUid == uid)
                          ? indicatorSelectedDecoration
                          : indicatorDecoration,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: widget.height - 2,
                        child: Center(
                          child: widget.iconSvg != null
                              ? SvgPicture.string(
                            widget.iconSvg!,
                            width: iconSize,
                            height: iconSize,
                            colorFilter: Ide.hoverLeftMenuButtonUid == uid || (Ide.selectedMenuUid == uid) ? ColorFilter.mode(iconSelectedColor!, BlendMode.srcIn) : ColorFilter.mode(iconColor!, BlendMode.srcIn),
                          )
                              : Icon(
                            widget.icon,
                            color: Ide.hoverLeftMenuButtonUid == uid || (Ide.selectedMenuUid == uid) ? iconSelectedColor : iconColor,
                            size: iconSize,
                          ),
                          /*child: ,*/
                        ),
                      ),
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
