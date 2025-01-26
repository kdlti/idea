import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdeSwitchListItem extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Icon? icon;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final IdeSwitchListStyle? style;
  final bool enabled;

  const IdeSwitchListItem({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.style,
    this.subTitle,
    this.icon,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final IdeSwitchListStyle listSwitchStyle = Theme.of(context).extension<IdeSwitchListStyle>()!;

    final BoxDecoration? decoration = style?.decoration ?? listSwitchStyle.decoration;
    final EdgeInsetsGeometry? padding = style?.padding ?? listSwitchStyle.padding;
    final EdgeInsetsGeometry? margin = style?.margin ?? listSwitchStyle.margin;

    final styleTitle = style?.title ?? listSwitchStyle.title;
    final styleSubTitle = style?.subTitle ?? listSwitchStyle.subTitle;

    return Container(
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 4, top: 2),
            child: icon ?? const SizedBox(width: 0),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: styleTitle,
                  ),
                  IdeVisibilityBuilder(
                    condition: subTitle != null && subTitle!.isNotEmpty,
                    child: () => Text(subTitle!, style: styleSubTitle),
                  ),
                ],
              ),
            ),
          ),
          IgnorePointer(
            ignoring: onChanged == null,
            child: Opacity(
              opacity: onChanged != null ? 1 : 0.5,
              child: IdeVisibilityToggle(
                condition: enabled,
                firstChild: () => SizedBox(
                  width: 40,
                  child: Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      value: value,
                      onChanged: onChanged,
                    ),
                  ),
                ),
                secondChild: () => const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.check_circle_outline, color: Colors.green, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
