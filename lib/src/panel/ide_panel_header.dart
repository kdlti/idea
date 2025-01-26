import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdePanelHeader extends StatelessWidget {
  final double height;
  final IconData? icon;
  final String? title;
  final String? subTitle;
  final IdePanelHeaderStyle? style;
  final VoidCallback? onClose;
  final List<Widget>? actions;
  final bool showCloseButton;

  const IdePanelHeader({
    super.key,
    this.height = 42,
    this.icon,
    this.title,
    this.subTitle,
    this.style,
    this.onClose,
    this.actions,
    this.showCloseButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final IdePanelHeaderStyle defaultStyle = Theme.of(context).extension<IdePanelHeaderStyle>() ?? const IdePanelHeaderStyle();
    final EdgeInsetsGeometry? margin = style?.margin ?? defaultStyle.margin;
    final EdgeInsetsGeometry? padding = style?.padding ?? defaultStyle.padding;
    final BoxDecoration? decoration = style?.decoration ?? defaultStyle.decoration;

    return Container(
      margin: margin,
      padding: padding,
      decoration: decoration,
      height: height,
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 18),
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                title!,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          if (subTitle != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(subTitle!, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ),
          const Spacer(),
          if (actions != null) ...actions!,
          if (showCloseButton)
            IdeIconButton(
              iconData: Icons.clear,
              onPressed: () {
                Ide.hidePanelRight();
                if (onClose != null) {
                  onClose?.call();
                }
              },
            ),
        ],
      ),
    );
  }
}
