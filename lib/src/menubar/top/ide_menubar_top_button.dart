import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/menubar/top/ide_menubar_top_button_close.dart';

class IdeMenubarTopButton extends StatefulWidget {
  final VoidCallback onActive;
  final VoidCallback onClose;
  final String uid;
  final String label;
  final String tooltip;
  final bool showTooltip;
  final IconData? icon;
  final bool alowClose;

  const IdeMenubarTopButton({
    super.key,
    required this.onClose,
    required this.onActive,
    required this.label,
    required this.tooltip,
    required this.uid,
    required this.icon,
    required this.alowClose,
    required this.showTooltip,
  });

  @override
  State<IdeMenubarTopButton> createState() => IdeMenubarTopButtonState();
}

class IdeMenubarTopButtonState extends State<IdeMenubarTopButton> {
  void redraw() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    Ide.menubarTop!.addButtonState(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final IdeMenubarTopStyle defaultStyle = Theme.of(context).extension<IdeMenubarTopStyle>()!;

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

    return MouseRegion(
      onEnter: (value) {
        setState(() {
          Ide.hoverMenubarTopUid = widget.uid;
        });
      },
      onExit: (value) {
        setState(() {
          Ide.hoverMenubarTopUid = '';
        });
      },
      child: InkWell(
        onTap: () {
          widget.onActive();
          Ide.hoverMenubarTopUid = '';
        },
        child: Tooltip(
          message: widget.showTooltip ? widget.tooltip : '',
          child: Container(
            decoration: Ide.hoverMenubarTopUid == widget.uid
                ? buttonHoverDecoration
                : ((Ide.activeContent!.uid == widget.uid) ? buttonSelectedDecoration : buttonDecoration),
            child: ClipRRect(
              /*borderRadius:
                  buttonDecoration != null ? buttonDecoration.borderRadius! : BorderRadius.zero,*/
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
                          color: Ide.hoverMenubarTopUid == widget.uid
                              ? iconHoverColor
                              : (Ide.activeContent!.uid == widget.uid)
                                  ? iconSelectedColor
                                  : iconColor,
                        ),
                        buttonHorizontalGap,
                        Text(
                          widget.label,
                          style: Ide.hoverMenubarTopUid == widget.uid
                              ? textHover
                              : (Ide.activeContent!.uid == widget.uid)
                                  ? textSelected
                                  : text,
                        ),
                        buttonHorizontalGap,
                        IdeVisibilityBuilder(
                          condition: (Ide.workspaceManager!.listContent.length > 1 && widget.alowClose),
                          child: () => IdeMenubarTopButtonClose(onPressed: widget.onClose, size: 13),
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
                          decoration: ((Ide.activeContent!.uid == widget.uid)
                              ? indicatorSelectedDecoration
                              : Ide.hoverMenubarTopUid == widget.uid
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
