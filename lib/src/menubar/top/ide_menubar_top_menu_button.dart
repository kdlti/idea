import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menu/ide_menu_abastract.dart';
import 'package:idea/src/menu/ide_menu_overlay.dart';
import 'package:idea/src/security/security.dart';
import 'package:idea/src/size/ide_position.dart';

// ignore: must_be_immutable
class IdeMenubarTopMenuButton extends StatefulWidget {
  final bool enabled;
  final IconData icon;
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

  const IdeMenubarTopMenuButton({
    super.key,
    required this.icon,
    required this.width,
    required this.height,
    this.enabled = true,
    this.menuWidth = 150,
    this.menu,
    this.tooltip = "",
  });

  @override
  State<IdeMenubarTopMenuButton> createState() => _IdeMenubarTopMenuButtonState();
}

class _IdeMenubarTopMenuButtonState extends State<IdeMenubarTopMenuButton> {
  String uid = ApiSecurity.uid();

  Offset btnOffset(RelativeRect btnRect, IdeMenuBoxRender menuBoxRender) {
    return Offset(36 - widget.menuWidth!, 0);
  }

  Widget buildButton(BuildContext context) {
    /*
    TODO:: Implementar style em IdeMenubarTopMenuButton
    final IdeMenubarLeftStyle defaultStyle = Theme.of(context).extension<IdeMenubarLeftStyle>()!;

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
    final double? indicatorWidth = defaultStyle.indicatorWidth;*/

    return MouseRegion(
      onEnter: (value) {
        setState(
          () {
            Ide.hoverLeftMenuButtonUid = uid;

            if (mounted && widget.menu != null && widget.menu!.isNotEmpty) {
              IdeMenuOverlayState? menuScreenOverlayState = Ide.state.find("IdeMenuOverlayState");

              if (menuScreenOverlayState != null) {
                IdeMenuBoxRender menuBoxRender = IdeMenuBoxRender(width: widget.menuWidth!, children: widget.menu!);
                RelativeRect btnRect = IdePosition.global(context, const Offset(0, 0));

                if (widget.enabled && Ide.menuOverlay != null) {
                  menuScreenOverlayState.menuItemRegister(this);
                  menuScreenOverlayState.resetSubmenu();
                  IdeMenubarTopMenuButton.activeMenuUid = uid;
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
          Ide.selectedMenuUid = '';
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        height: 25,
        width: 25,
        //color: Colors.red,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.more_horiz_outlined, size: 20),
          splashRadius: 5,
          onPressed: () {
            IdeMenuOverlayState? menuScreenOverlayState = Ide.state.find("IdeMenuOverlayState");
            if (menuScreenOverlayState != null) {
              if (widget.menu != null && widget.menu!.isNotEmpty) {
                if (Ide.hoverLeftMenuButtonUid == uid && mounted && Ide.menuOverlay != null) {
                  Ide.selectedMenuUid = uid;

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
              } else {
                menuScreenOverlayState.hide();
                Ide.selectedMenuUid = '';
              }
            }
          },
        ),
      ),
      /*child: InkWell(
        onTap: ,
        hoverColor: Colors.transparent,
        child: Column(
          children: [
            Container(
              padding: buttonPadding,
              margin: buttonMargin,
              alignment: Alignment.center,
              width: widget.width,
              height: widget.height,
              decoration: Ide.hoverLeftMenuButtonUid == uid ? buttonHoverDecoration : ((Ide.selectedMenuUid == uid) ? buttonSelectedDecoration : buttonDecoration),
              child: Container(
                alignment: Alignment.center,
                height: widget.height - 2,
                child: Center(
                  child: Icon(
                    widget.icon,
                    color: Ide.hoverLeftMenuButtonUid == uid || (Ide.selectedMenuUid == uid) ? iconSelectedColor : iconColor,
                    size: iconSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),*/
    );
  }

  /*Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              height: 25,
              width: 25,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.more_horiz_outlined),
                tooltip: 'Increase volume by 10',
                splashRadius: 5,
                onPressed: () {},
              ),
            )*/

  @override
  Widget build(BuildContext context) {
    return IdeVisibilityToggle(
      condition: widget.enabled,
      firstChild: () => buildButton(context),
      secondChild: () => IgnorePointer(
        ignoring: true,
        child: Opacity(
          opacity: 0.3,
          child: buildButton(context),
        ),
      ),
    );
  }
}
