import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menu/ide_menu_overlay.dart';

class IdeMenubarBottomButtonTab extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;
  final String label;
  final String uid;

  const IdeMenubarBottomButtonTab({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip = "",
    this.label = "",
    required this.uid,
  });

  @override
  State<IdeMenubarBottomButtonTab> createState() => IdeMenubarBottomButtonTabState();
}

class IdeMenubarBottomButtonTabState extends State<IdeMenubarBottomButtonTab> {
  @override
  void initState() {
    Ide.activeContent!.panelBottomManager.registerButtonTab(this);
    super.initState();
  }

  void redraw() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Ide.panelBottom == null) {
      return const SizedBox.shrink();
    }

    final IdeMenubarBottomStyle defaultStyle = Theme.of(context).extension<IdeMenubarBottomStyle>()!;

    final Color? iconColor = defaultStyle.iconColor;
    final Color? iconHoverColor = defaultStyle.iconHoverColor;
    final Color? iconSelectedColor = defaultStyle.iconSelectedColor;

    final EdgeInsetsGeometry? indicatorMargin = defaultStyle.indicatorMargin;

    final TextStyle? text = defaultStyle.text;
    final TextStyle? textHover = defaultStyle.textHover;
    final TextStyle? textSelected = defaultStyle.textSelected;

    final BoxDecoration? buttonDecoration = defaultStyle.buttonDecoration;
    final BoxDecoration? buttonHoverDecoration = defaultStyle.buttonHoverDecoration;
    final BoxDecoration? buttonSelectedDecoration = defaultStyle.buttonSelectedDecoration;

    final BoxDecoration? indicatorDecoration = defaultStyle.indicatorDecoration;
    final BoxDecoration? indicatorHoverDecoration = defaultStyle.indicatorHoverDecoration;
    final BoxDecoration? indicatorSelectedDecoration = defaultStyle.indicatorSelectedDecoration;
    final SizedBox buttonHorizontalGap = SizedBox(width: defaultStyle.buttonHorizontalGap ?? 0);

    final EdgeInsetsGeometry? buttonPadding = defaultStyle.buttonPadding;
    final EdgeInsetsGeometry? buttonMargin = defaultStyle.buttonMargin;
    final double? indicatorHeight = defaultStyle.indicatorHeight;
    final double? iconSize = defaultStyle.iconSize;

    final bool showTooltip = defaultStyle.showTooltip;
    final double height = Ide.menubarBottom!.size.height;

    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        setState(() {
          Ide.hoverBottomTabUid = widget.uid;
        });
      },
      onExit: (PointerExitEvent event) {
        setState(() {
          Ide.hoverBottomTabUid = "";
        });
      },
      child: InkWell(
        onTap: () {
          IdeMenuOverlayState? menuScreenOverlayState = Ide.state.find("IdeMenuOverlayState");
          if (menuScreenOverlayState != null) {
            menuScreenOverlayState.hide();
          }
          widget.onPressed();
          Ide.hoverBottomTabUid = "";
        },
        child: Tooltip(
          message: showTooltip ? widget.tooltip : '',
          child: Container(
            height: height,
            decoration: Ide.hoverBottomTabUid == widget.uid
                ? buttonHoverDecoration
                : ((Ide.panelBottom!.uid == widget.uid) ? buttonSelectedDecoration : buttonDecoration),
            child: ClipRRect(
              //TODO:: Resolver borderRadius: buttonDecoration != null ? buttonDecoration.borderRadius! : BorderRadius.zero,
              //borderRadius: buttonDecoration != null ? buttonDecoration.borderRadius! : BorderRadius.zero,
              child: Stack(
                children: [
                  Container(
                    padding: buttonPadding,
                    margin: buttonMargin,
                    child: Row(
                      children: [
                        Icon(
                          widget.icon,
                          size: iconSize,
                          color: Ide.hoverBottomTabUid == widget.uid
                              ? iconHoverColor
                              : (Ide.panelBottom!.uid == widget.uid)
                                  ? iconSelectedColor
                                  : iconColor,
                        ),
                        buttonHorizontalGap,
                        Text(
                          widget.label,
                          style: Ide.hoverBottomTabUid == widget.uid
                              ? textHover
                              : (Ide.panelBottom!.uid == widget.uid)
                                  ? textSelected
                                  : text,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: indicatorMargin,
                      child: Center(
                        child: Container(
                          decoration: ((Ide.panelBottom!.uid == widget.uid)
                              ? indicatorSelectedDecoration
                              : Ide.hoverBottomTabUid == widget.uid
                                  ? indicatorHoverDecoration
                                  : indicatorDecoration),
                          height: indicatorHeight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
