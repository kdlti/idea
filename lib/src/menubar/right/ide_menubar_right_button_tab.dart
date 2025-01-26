import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menu/ide_menu_overlay.dart';

class IdeMenubarRightButtonTab extends StatefulWidget {
  final bool enabled;
  final IconData icon;
  final String? iconSvg;
  final bool divider;
  final VoidCallback onPressed;
  final double width;
  final double? menuWidth;
  final double height;
  final String tooltip;
  final String uid;

  const IdeMenubarRightButtonTab({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.uid,
    this.enabled = true,
    this.divider = false,
    this.menuWidth = 240,
    this.tooltip = "",
    this.iconSvg,
  });

  @override
  State<IdeMenubarRightButtonTab> createState() => IdeMenubarRightButtonTabState();
}

class IdeMenubarRightButtonTabState extends State<IdeMenubarRightButtonTab> {
  bool isHover = false;

  @override
  void initState() {
    Ide.activeContent!.panelRightManager.registerButtonTab(this);
    super.initState();
  }

  void redraw() {
    if (mounted) {
      setState(() {});
    }
  }

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

    return Obx(() => Tooltip(
          message: widget.tooltip,
          child: InkWell(
            onTap: () {
              IdeMenuOverlayState? menuScreenOverlayState = Ide.state.find("IdeMenuOverlayState");
              if (menuScreenOverlayState != null) {
                menuScreenOverlayState.hide();
                widget.onPressed();
                Ide.activeContent!.panelRightSelected = widget.uid;
              }
            },
            onHover: (bool value) {
              setState(() {
                isHover = value;
              });
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
                  decoration: isHover || (Ide.activeContent!.panelRightSelected == widget.uid)
                      ? buttonHoverDecoration
                      : ((Ide.activeContent!.panelRightSelected == widget.uid) ? buttonSelectedDecoration : buttonDecoration),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                                    colorFilter: isHover || (Ide.activeContent!.panelRightSelected == widget.uid)
                                        ? ColorFilter.mode(iconSelectedColor!, BlendMode.srcIn)
                                        : ColorFilter.mode(iconColor!, BlendMode.srcIn),
                                  )
                                : Icon(
                                    widget.icon,
                                    color: isHover || (Ide.activeContent!.panelRightSelected == widget.uid) ? iconSelectedColor : iconColor,
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
                        decoration: isHover || (Ide.activeContent!.panelRightSelected == widget.uid)
                            ? indicatorSelectedDecoration
                            : indicatorDecoration,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
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
