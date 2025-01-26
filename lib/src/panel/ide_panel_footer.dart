import 'package:flutter/material.dart';
import 'package:idea/src/panel/ide_panel_footer_style.dart';

class IdePanelFooter extends StatelessWidget {
  final double height;
  final IdePanelFooterStyle? style;
  final List<Widget>? actionLeft;
  final List<Widget>? actionCenter;
  final List<Widget>? actionRight;

  const IdePanelFooter({
    super.key,
    this.height = 42,
    this.actionLeft,
    this.actionCenter,
    this.actionRight,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final IdePanelFooterStyle defaultStyle = Theme.of(context).extension<IdePanelFooterStyle>() ?? const IdePanelFooterStyle();
    final EdgeInsetsGeometry? margin = style?.margin ?? defaultStyle.margin;
    final EdgeInsetsGeometry? padding = style?.padding ?? defaultStyle.padding;
    final BoxDecoration? decoration = style?.decoration ?? defaultStyle.decoration;

    return Container(
      margin: margin,
      padding: padding,
      decoration: decoration,
      child: Row(
        children: [
          if (actionLeft != null) Row(children: actionLeft!),
          const Spacer(),
          if (actionCenter != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: actionCenter!,
            ),
          const Spacer(),
          if (actionRight != null)
            Row(
              children: actionRight!,
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
        ],
      ),
    );
  }
}
