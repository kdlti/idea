part of '../package.dart';

enum _ArrowDirection { top, bottom }

class IdeCustomPopup extends StatelessWidget {
  final GlobalKey? anchorKey;
  final Widget content;
  final Widget child;
  final bool isLongPress;
  final Color? backgroundColor;
  final Color? arrowColor;
  final Color? barrierColor;
  final bool showArrow;
  final String tooltip;

  const IdeCustomPopup({
    super.key,
    required this.content,
    required this.child,
    this.anchorKey,
    this.isLongPress = false,
    this.backgroundColor,
    this.arrowColor,
    this.showArrow = true,
    this.barrierColor,
    this.tooltip = '',
  });

  void _show(BuildContext context) {
    final anchor = anchorKey?.currentContext ?? context;
    final renderBox = anchor.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final offset = renderBox.localToGlobal(renderBox.paintBounds.topLeft);
    Navigator.of(context).push(IdeCustomPopupRoute(
      targetRect: offset & renderBox.paintBounds.size,
      backgroundColor: backgroundColor,
      arrowColor: arrowColor,
      showArrow: showArrow,
      barriersColor: barrierColor,
      child: content,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return  Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onLongPress: isLongPress ? () => _show(context) : null,
          onTapUp: !isLongPress ? (_) => _show(context) : null,
          child: child,
        ),
      ),
    );
  }
}






